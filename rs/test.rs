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
#[cfg(test)]
mod test {
	use super::*;

	#[test]
	fn test() {
		let p = problema(8);
		let r = Vec::from([1, 3, 5, 7]);

		assert_eq!(p, r);
	}
} 