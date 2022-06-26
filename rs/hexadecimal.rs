fn to_integer(hex: String) -> String {
	u32::from_str_radix(hex.trim_start_matches("0x"), 16)
		.unwrap_or(0)
		.to_string()
}

fn to_hex(int: String) -> String {
	format!("0x{:X}", int.parse::<u32>().unwrap())
}