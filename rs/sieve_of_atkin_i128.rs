// Este algoritmo retorna uma lista de todos os numeros primos até limit

fn sieve_of_atkin(limit: i128) -> Vec<i128> {
    let mut numbers: Vec<i128> = Vec::new();

    if limit > 2 {
        numbers.push(2);
    }
    
    if limit > 3 {
        numbers.push(3);
    }

    let mut sieve = vec![false; (limit + 1) as usize];

    let mut x: i128 = 1;
    let mut y: i128;
    let mut n: i128;

    while x.pow(2) <= limit {
        y = 1;
        while y.pow(2) <= limit {
            n = (4 * x.pow(2)) + y.pow(2); 

            if n <= limit && (n % 12 == 1 || n % 12 == 5) {
                sieve[n as usize] = true;
            }

            n = (3 * x.pow(2)) + y.pow(2);
            if n <= limit && n % 12 == 7 {
                sieve[n as usize] = true;
            }

            n = (3 * x.pow(2)) - y.pow(2);
            if x > y && n <= limit && n % 12 == 11 {
                sieve[n as usize] = true;
            }

            y += 1;
        }
        x += 1;
    }

    let mut r: i128 = 5;
    while r.pow(2) <= limit {
        if sieve[r as usize] {
            for i in (r.pow(2)..=limit).step_by(r.pow(2) as usize){
                sieve[i as usize] = false;
            }
        }
        r += 1;
    }

    for a in 5..=limit {
        if sieve[a as usize] {
            numbers.push(a);
        }
    }
 
    return numbers;
}