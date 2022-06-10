fn string_to_f64(string: String) -> f64 {
	return string
			.trim()
			.parse::<f64>()
			.expect("an error happed in convertion Stringo to Int64");
}