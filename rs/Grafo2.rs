type MatrizGrafo = Vec<Vec<bool>>;

#[derive(PartialEq, Eq, PartialOrd, Ord, Hash, Clone, Debug)]
struct Grafo {
	matriz: MatrizGrafo
}

impl Grafo {
	fn new(t: usize) -> Grafo {
		Grafo {
			matriz: vec![vec![false; t]; t]
		}
	}
	
	fn inserir_conexao(&mut self, a: usize, b: usize) {
		self.matriz[a - 1][b - 1] = true;
		self.matriz[b - 1][a - 1] = true;
	}

	fn numero_conexoes(&self, no: usize) -> usize {
		self.matriz[no].iter()
						.filter(|x| **x)
						.collect::<Vec<&bool>>()
						.len() as usize | 0
	}

	fn verificar_conexao(&self, a: usize, b: usize) -> bool {
		self.matriz[a - 1][b - 1]
	}
}