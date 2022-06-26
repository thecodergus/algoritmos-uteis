type T = u64;

fn inputline_vector_u64() -> Vec<T> {
	let mut input_line = String::new();

	std::io::stdin()
			.read_line(&mut input_line)
			.expect("failed to read from stdin");

	return input_line
				.to_string()
				.split_whitespace()
				.into_iter()
				.map(|x| x.trim().parse::<T>().unwrap_or(0))
				.collect::<Vec<T>>();
}