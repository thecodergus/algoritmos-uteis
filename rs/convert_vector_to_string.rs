fn convert_vector_to_string(vetor: Vec<i64>) -> Vec<String> {
	vetor
		.iter()
		.map(|x| x.to_string())
		.collect::<Vec<String>>()