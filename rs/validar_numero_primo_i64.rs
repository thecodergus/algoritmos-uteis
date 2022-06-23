fn validar_numero_primo_i64(n: i64) -> bool {
	if n <= 1 {
		return false;
	}

	for i in 2..=(((n as f64).sqrt()) as i64) {
		if n % i == 0 {
			return false;
		}
	}

	return true;
}