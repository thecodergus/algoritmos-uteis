struct Perceptron {
    wigths: Vec<f64>,
}

impl Perceptron {
    fn new(num_inputs: u64) -> Self {
        Perceptron {
            wigths: (0..num_inputs).map(|_| 1.0).collect(),
        }
    }

    fn predict(self, inputs: Vec<f64>) -> Result<f64, &'static str> {
        if self.wigths.len() != inputs.len() {
            return Err("O comprimento dos pesos não corresponde ao comprimento das entradas");
        }
        let summation: f64 = self
            .wigths
            .iter()
            .zip(inputs.iter())
            .map(|(w, x)| w * x)
            .sum();

        return Ok(match summation > 0.0 {
            true => summation,
            false => 0.0,
        });
    }
}