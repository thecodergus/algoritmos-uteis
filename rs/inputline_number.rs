type T = i64;
fn inputline() -> T {
	let mut input_line = String::new();

	std::io::stdin()
		.read_line(&mut input_line)
		.expect("failed to read from stdin");

	return input_line.to_string()
						.trim()
						.parse::<T>()
						.unwrap_or(0);
}