fn inputline() -> String {
	let mut input_line = String::new();

	std::io::stdin()
		.read_line(&mut input_line)
		.expect("failed to read from stdin");

	return input_line.to_string().replace("\n", "");
}

fn inputline_i64() -> i64 {
    return inputline()
            .trim()
            .parse::<i64>()
            .expect("an error happed in convertion Stringo to Int64");
}