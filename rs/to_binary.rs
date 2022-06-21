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

fn to_string_u32(n: String, tamanho_bit: u32) -> u32 {
 	let mut cont: u32 = 0;
	
	for (i, value) in n.chars().collect::<Vec<char>>().iter().rev().enumerate() {
		if *value == '1' {
			cont += u32::pow(2, i as u32);
		}
	}

	return cont;
}

#[cfg(test)]
mod test {
	use super::*;

	#[test]
	fn test_1() {
		let p: u32 = 10;

		assert_eq!(p, to_string_u32(to_u32_string(p, 32), 32));
	}
} 