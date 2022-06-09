fn splitline(string: String, splitter: &str) -> Vec<String> {
	let itens: Vec<&str> = string.split(splitter).collect();

	let mut result: Vec<String> = Vec::new();

	for i in itens {
		result.push(i.to_string().replace("\n", ""));
	}
	
	return result;
}