fn main() {
    println!("{}", ackermann (4, 1));
}

fn ackermann(m: u32, n: u32) -> u32 {
	return match (m, n) {
		(0, n) => n + 1,
		(1, n) => 2 + (n + 3) - 3,
		(2, n) => 2 * (n + 3) - 3,
		(3, n) => u32::pow(2, n + 3) - 3,
		(4, n) => pot(n + 3),
		(_, _) => 0
	}
}

fn pot(x: u32) -> u32 {
	return match x {
		0 => 1,
		_ => u32::pow(2, pot(x - 1))
	}
}