fn mult_itens_array(vetor: Vec<i64>) -> i64 {
	let mut cont = 1;

	for i in vetor {
		cont *= i;
	}

	return cont;
}