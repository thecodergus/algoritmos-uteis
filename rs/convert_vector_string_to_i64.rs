fn convert_vector_string_to_i64(vetor: Vec<String>) -> Vec<i64> {
	let mut result: Vec<i64> = Vec::new();

	for i in vetor {
		result.push(i.to_string().parse::<i64>().unwrap());
	}

	return result;
}