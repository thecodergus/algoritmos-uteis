use std::collections::HashMap;

// Structs
struct Grafo {
	grafo: grafo,
	nodos: Vec<String>,
	arestas: Vec<ligacao>
}

struct Nodo {
	de: String,
	para: String,
	valor: i64
}

struct Ligacao(String, String);

// Custom Types
type ligacao = (String, String);
type grafo = HashMap<ligacao, Nodo>;

trait ProjetoNodo {
	fn new(de: String, para: String, valor: i64) -> Nodo;
	fn clone(&self) -> Nodo;
}

impl ProjetoNodo for Nodo {
	fn new(de: String, para: String, valor: i64) -> Nodo {
		Nodo {
			de,
			para,
			valor
		}
	}

	fn clone(&self) -> Nodo {
		Nodo {
			de: self.de.clone(),
			para: self.para.clone(),
			valor: self.valor.clone()
		}
	}
}

trait ProjetoGrafo {
	fn new() -> Grafo;
	fn clone(&self) -> Grafo;
	fn add_nodo_aresta(&mut self, chave: ligacao, valor: i64);
	fn add_nodo(&mut self, no: String);
	fn remover_nodo(&mut self, no: String);
	
	fn verificar_se_existe_nodo(&self, no: &String) -> bool;
	fn get_numero_nodos(&self) -> u64;

	// Nos / Vertice (elemento posicionado)
	

	// Aresta (ligação)
	fn remove_aresta(&mut self, chave: ligacao);
	fn verificar_se_existe_aresta(&self, aresta: &ligacao) -> bool;
	// fn add_aresta(ligacao: ligacao, valor: i64);
	fn get_all_grafo(&self) -> Vec<Nodo>;
	fn get_show_all_grafo(&self) -> Vec<String>;
	fn get_numero_arestas(&self) -> u64;
}

impl ProjetoGrafo for Grafo {
	fn new() -> Grafo {
		Grafo {
			grafo: HashMap::new(),
			nodos: Vec::new(),
			arestas: Vec::new()
		}
	}

	fn clone(&self) -> Grafo {
		let mut g: grafo = HashMap::new();

		for (key, value) in &self.grafo {
			g.insert(
				(*key).clone(),
				(*value).clone()
			);
		}
		
		Grafo {
			grafo: g,
			nodos: self.nodos.clone(),
			arestas: self.arestas.clone()
		}
	}

	fn add_nodo_aresta(&mut self, chave: ligacao, valor: i64) {
		if !self.verificar_se_existe_nodo(&chave.0) {
			self.add_nodo(chave.0.clone());
		}

		if !self.verificar_se_existe_nodo(&chave.1) {
			self.add_nodo(chave.1.clone());
		}

		if !self.verificar_se_existe_aresta(&chave) {
			self.arestas.push(chave.clone());
		}
		
		self.grafo.insert(
			chave.clone(), 
			Nodo::new(
				chave.0,
				chave.1,
				valor
			)
		);
	}

	fn get_all_grafo(&self) -> Vec<Nodo> {
		let mut result: Vec<Nodo> = Vec::new();

		for (_, value) in &self.grafo {
			result.push((*value).clone());
		}

		return result;
	}

	fn get_show_all_grafo(&self) -> Vec<String> {
		let mut result: Vec<String> = Vec::new();

		for i in self.get_all_grafo() {
			result.push(format!("({}, {}, {})", i.de, i.para, i.valor));
		}

		return result;
	}

	fn add_nodo(&mut self, no: String) {
		if !self.verificar_se_existe_nodo(&no){
			self.nodos.push(no);
		}		
	}

	fn verificar_se_existe_nodo(&self, no: &String) -> bool{
		self.nodos.contains(no)
	}

	fn get_numero_nodos(&self) -> u64 {
		self.nodos.len() as u64
	}

	fn verificar_se_existe_aresta(&self, aresta: &ligacao) -> bool{
		self.arestas.contains(aresta)
	}

	fn get_numero_arestas(&self) -> u64 {
		self.arestas.len() as u64
	}

	fn remove_aresta(&mut self, chave: ligacao){
		if self.verificar_se_existe_aresta(&chave) {
			self.grafo.remove(&chave);
	
			if let Some(posicao) = self.arestas.iter().position(|x| *x == chave) {
			    self.arestas.swap_remove(posicao);
			}
		}
	}

	// Falta remover os itens de self.arestas
	fn remover_nodo(&mut self, no: String){
		if self.verificar_se_existe_nodo(&no) {
			let arestas: Vec<&ligacao> = self.arestas
									.iter()
									.filter(|(x, y)| *x == no || *y == no)
									.collect();

			for i in arestas {
				self.grafo.remove(i);
			}

			if let Some(index) = self.nodos.iter().position(|x| *x == no) {
				self.nodos.swap_remove(index);
			}
		}
	}
}

fn main() {
    let mut g: Grafo = Grafo::new();
	let mut exemplo: Vec<ligacao> = Vec::new();

	exemplo.push(
		("1".to_string(), "2".to_string())
	);
	exemplo.push(
		("2".to_string(), "1".to_string())
	);
	
	exemplo.push(
		("1".to_string(), "3".to_string())
	);
	exemplo.push(
		("3".to_string(), "1".to_string())
	);

	exemplo.push(
		("1".to_string(), "4".to_string())
	);
	exemplo.push(
		("4".to_string(), "1".to_string())
	);

	exemplo.push(
		("2".to_string(), "3".to_string())
	);
	exemplo.push(
		("3".to_string(), "2".to_string())
	);

	exemplo.push(
		("3".to_string(), "4".to_string())
	);
	exemplo.push(
		("4".to_string(), "3".to_string())
	);

	exemplo.push(
		("2".to_string(), "5".to_string())
	);
	exemplo.push(
		("5".to_string(), "2".to_string())
	);

	exemplo.push(
		("3".to_string(), "5".to_string())
	);
	exemplo.push(
		("5".to_string(), "3".to_string())
	);

	exemplo.push(
		("4".to_string(), "5".to_string())
	);
	exemplo.push(
		("5".to_string(), "4".to_string())
	);

	exemplo.push(
		("2".to_string(), "4".to_string())
	);
	exemplo.push(
		("4".to_string(), "2".to_string())
	);


	for i in exemplo {
		g.add_nodo_aresta((i.0, i.1), 0);
	}


	g.remover_nodo("2".to_string());
	
	for i in g.get_show_all_grafo() {
		println!("{}", i);
	}
	
}

