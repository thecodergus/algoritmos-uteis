fn convert_vector_to_string(vetor: Vec<i64>) -> Vec<String> {
	let mut result: Vec<String> = Vec::new();

	for i in vetor {
		result.push(i.to_string());
	}

	return result;
}