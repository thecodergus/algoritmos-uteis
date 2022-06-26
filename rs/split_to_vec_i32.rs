fn split_to_vec_i32(vetor: String) -> Vec<i32> {
	vetor
		.split_whitespace()
		.into_iter()
		.map(|x| x.trim().parse::<i32>().unwrap_or(0))
		.collect::<Vec<i32>>()
}