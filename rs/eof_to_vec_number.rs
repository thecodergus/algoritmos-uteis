type T = u64;

fn eof() -> Vec<T> {
	let mut result: Vec<T> = Vec::new();
	let mut buffer = String::new();

	let mut bytes: usize;

	loop {
		bytes = std::io::stdin()
			.read_line(&mut buffer)
			.unwrap();

		if bytes == 0 {
	        break;
	    }

		let entrada: Vec<T> = buffer
								.to_string()
								.replace("\n", "")
								.split_whitespace()
								.into_iter()
								.map(|x| x.trim().parse::<T>().unwrap_or(0))
								.collect::<Vec<T>>();
		
		result.push(problema(entrada[1], entrada[0]));

		buffer = String::from("");
	}

	return result;
}