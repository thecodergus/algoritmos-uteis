fn convert_vector_string_to_i64(vetor: Vec<String>) -> Vec<i64> {
	let mut result: Vec<i64> = Vec::new();

	for i in vetor {
		result.push(i.to_string().parse::<i64>().unwrap());
	}

	return result;
}

fn splitline(string: String, splitter: &str) -> Vec<String> {
	let itens: Vec<&str> = string.split(splitter).collect();

	let mut result: Vec<String> = Vec::new();

	for i in itens {
		result.push(i.to_string().replace("\n", ""));
	}
	
	return result;
}

fn string_to_monada_i64(string: String) -> (i64, i64) {
	let aux: Vec<i64> = convert_vector_string_to_i64(splitline(string, " "));

	return (aux[0], aux[1]);
}