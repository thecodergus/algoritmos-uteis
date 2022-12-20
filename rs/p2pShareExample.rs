// This code was write by ChatGPT
use std::env;
use std::net::{TcpListener, TcpStream};
use std::thread;
use std::io::{Read, Write};

fn handle_client(mut stream: TcpStream) {
    let mut data = [0 as u8; 50]; // cria um buffer de 50 bytes
    while match stream.read(&mut data) {
        Ok(size) => {
            // Escreve o conteúdo do buffer de volta para o cliente
            stream.write(&data[0..size]).unwrap();
            true
        }
        Err(_) => {
            println!("Falha ao ler a partir do stream");
            false
        }
    } {}
}

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();
    println!("Ouvindo por conexões na porta 7878");

    // Aceita as conexões em um loop infinito
    for stream in listener.incoming() {
        match stream {
            Ok(stream) => {
                println!("Nova conexão: {}", stream.peer_addr().unwrap());
                thread::spawn(|| handle_client(stream));
            }
            Err(e) => {
                println!("Erro: {}", e);
            }
        }
    }

    // Fecha o listener
    drop(listener);
}
