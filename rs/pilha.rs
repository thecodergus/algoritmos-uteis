#[derive(PartialEq, Eq, PartialOrd, Ord, Hash, Clone, Debug)]
struct Pilha{
	data: Vec<String>
}

impl Pilha {
	fn new() -> Pilha {
		Pilha {
			data: Vec::new()
		}
	}

	fn adicionar_elemento(&mut self, e: String){
		self.data.push(e);
	}

	fn remover_elemento(&mut self) -> String {
		match self.data.pop() {
			Some(x) => x,
			_ => "".to_string()
		}
	}

	fn tamanho_pilha(&self) -> usize {
		self.data.len()
	}
}

fn main() {
    println!("Hello, world!");
}