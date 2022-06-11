fn eof_to_vector_string() -> Vec<String> {
	let mut result: Vec<String> = Vec::new();
	let mut buffer = String::new();

	let mut bytes: usize;

	loop {
		bytes = std::io::stdin()
			.read_line(&mut buffer)
			.unwrap();

		if bytes == 0 {
	        break;
	    }

		result.push(buffer.to_string().replace("\n", ""));

		buffer = String::from("");
	}

	return result;
}

fn convert_vector_string_to_u64(vetor: Vec<String>) -> Vec<u64> {
	let mut result: Vec<u64> = Vec::new();

	for i in vetor {
		result.push(i.to_string().parse::<u64>().unwrap());
	}

	return result;
}

fn input_eof_to_vector_u64() -> Vec<u64> {
    return convert_vector_string_to_u64(eof_to_vector_string());
}