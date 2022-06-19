fn main() {
    let entrada: u64 = inputline_u64();

	println!("0 {}", problema(0, 1, entrada - 1));
}


// Retorna os N primeiros termos da serie
// Fibonacci
fn fibonacci(a: u64, b: u64,  quantidade_repeticoes: u64) -> String {
	match quantidade_repeticoes {
		1 => format!("{}", b),
		_ => format!("{} {}", b, fibonacci(b, b + a, quantidade_repeticoes - 1))
	}
}

fn inputline() -> String {
	let mut input_line = String::new();

	std::io::stdin()
		.read_line(&mut input_line)
		.expect("failed to read from stdin");

	return input_line.to_string().replace("\n", "");
}

fn string_to_u64(string: String) -> u64 {
	return string
			.trim()
			.parse::<u64>()
			.expect("an error happed in convertion Stringo to Int64");
}

fn inputline_u64() -> u64 {
    return string_to_u64(inputline());
            
}