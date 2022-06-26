fn convert_vector_string_to_i32(vetor: Vec<String>) -> Vec<i32> {
	vetor
		.iter()
		.map(|x| x.trim().parse::<i32>().unwrap_or(0))
		.collect::<Vec<i32>>()
}