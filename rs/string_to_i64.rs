fn string_to_i64(string: String) -> i64 {
	return string
			.trim()
			.parse::<i64>()
			.expect("an error happed in convertion Stringo to Int64");
}