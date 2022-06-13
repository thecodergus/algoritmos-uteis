fn fatorial(n: u128) -> u128 {
	if n == 1 {
		return 1;
	}

	return n * fatorial(n - 1);
}