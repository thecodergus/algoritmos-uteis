fn main() {
    println!("Hello, world!");
}

fn triangulo_pascal(m: isize, n: isize) -> usize {
	match (m, n){
		(0, 0) => 1,
		(-1, _) | (_, -1) => 0,
		_ => triangulo_pascal(m - 1, n - 1) + triangulo_pascal(m - 1, n)
	}
}