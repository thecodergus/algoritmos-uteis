struct Perceptron {
    wigths: Vec<f64>,
}

impl Perceptron {
    fn new(num_inputs: u64) -> Self {
        Perceptron {
            wigths: (0..num_inputs).map(|_| 1.0).collect(),
        }
    }

    fn predict(self, inputs: Vec<f64>) -> f64 {
        let summation: f64 = self
            .wigths
            .iter()
            .zip(inputs.iter())
            .map(|(w, x)| w * x)
            .sum();

        return match summation > 0.0 {
            true => summation,
            false => 0.0,
        };
    }
}