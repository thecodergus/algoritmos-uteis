fn convert_vector_string_to_i64(vetor: Vec<String>) -> Vec<i64> {
	vetor
		.iter()
		.map(|x| x.parse::<i64>().unwrap_or(0))
		.collect::<Vec<i64>>()
}