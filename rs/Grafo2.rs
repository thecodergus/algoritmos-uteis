type MatrizGrafo = Vec<Vec<isize>>;

#[derive(PartialEq, Eq, PartialOrd, Ord, Hash, Clone, Debug)]
struct Grafo {
	matriz: MatrizGrafo,
	variacao: usize
}

impl Grafo {
	// fn new(tamanho: usize, variacao: usize) -> Grafo {
	fn new(tamanho: usize) -> Grafo {
		Grafo {
			matriz: vec![vec![-1; tamanho]; tamanho],
			// variacao: variacao
			variacao: 1
		}
	}
	
	fn inserir_conexao(&mut self, a: usize, b: usize, valor: isize) {
		self.matriz[a - self.variacao][b - self.variacao] = valor;
		self.matriz[b - self.variacao][a - self.variacao] = valor;
	}

	fn numero_conexoes(&self, no: usize) -> usize {
		self.matriz[no].iter()
						.filter(|x| **x >= 0)
						.collect::<Vec<&isize>>()
						.len() as usize | 0
	}

	fn verificar_se_existe_conexao(&self, a: usize, b: usize) -> bool {
		self.matriz[a - self.variacao][b - self.variacao] >= 0
	}

	fn conexoes(&self, a: usize) -> Vec<usize> {
		let mut result: Vec<usize> = Vec::new();

		for i in 0..self.matriz[a - self.variacao].len() {
			if (a - self.variacao) != i && self.matriz[a - self.variacao][i] > -1 {
				result.push(i + self.variacao);
			}
		}

		return result;
	}
}

fn main() {
	
}