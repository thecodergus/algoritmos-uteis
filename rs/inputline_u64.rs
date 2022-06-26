fn inputline_u64() -> u64 {
	let mut input_line = String::new();

	std::io::stdin()
		.read_line(&mut input_line)
		.expect("failed to read from stdin");

	return input_line.to_string()
						.trim()
						.parse::<u64>()
						.unwrap_or(0);
}