fn inputline_f64() -> f64 {
	let mut input_line = String::new();

	std::io::stdin()
		.read_line(&mut input_line)
		.expect("failed to read from stdin");

	return input_line.to_string()
						.trim()
						.parse::<f64>()
						.unwrap_or(0);
}