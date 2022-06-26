fn inputline_i64() -> i64 {
	let mut input_line = String::new();

	std::io::stdin()
		.read_line(&mut input_line)
		.expect("failed to read from stdin");

	return input_line.to_string()
						.trim()
						.parse::<i64>()
						.unwrap_or(0);
}