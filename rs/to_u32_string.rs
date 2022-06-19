fn main() {
    println!("{}", to_u32_string(4, 32));
}

fn to_u32_string(n: u32, tamanho_bit: u32) -> String {

	if n == 0 && tamanho_bit == 0{
		return 0.to_string();
	}
	
	if n == 1 && tamanho_bit == 0{
		return 1.to_string();
	}

	if n % 2 == 0 {
		return format!("{}0", to_u32_string(n / 2, tamanho_bit - 1));
	}

	return format!("{}1", to_u32_string(n / 2, tamanho_bit - 1));
	
}