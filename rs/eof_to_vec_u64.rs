fn eof() -> Vec<u64> {
	let mut result: Vec<u64> = Vec::new();
	let mut buffer = String::new();

	let mut bytes: usize;

	loop {
		bytes = std::io::stdin()
			.read_line(&mut buffer)
			.unwrap();

		if bytes == 0 {
	        break;
	    }

		let entrada: Vec<i64> = split_to_vec_i64(buffer.to_string().replace("\n", ""));
		
		result.push(problema(entrada[1], entrada[0]));

		buffer = String::from("");
	}

	return result;
}

fn split_to_vec_i64(vetor: String) -> Vec<i64> {
	vetor
		.split_whitespace()
		.into_iter()
		.map(|x| x.trim().parse::<i64>().unwrap_or(0))
		.collect::<Vec<i64>>()
}
