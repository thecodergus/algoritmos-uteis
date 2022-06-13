fn main() {
    println!("Hello, world!");
}

fn problema(valor: u64) -> Vec<u64> {
	let mut result: Vec<u64> = Vec::new();

	for i in (1..valor).step_by(2){
		result.push(i);
	}

	return result;
}

#[test]
fn caso_1() {
	assert_eq!(problema(8), Vec::from([1, 3, 5, 7]));
}