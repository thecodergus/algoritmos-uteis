fn maior_elemento_vector_i64(v: Vec<i64>) -> i64 {
	let mut maior_valor = v[0];

	for i in 1..v.len() {
		if maior_valor < v[i] {
			maior_valor = v[i];
		}
	}

	return maior_valor;
}