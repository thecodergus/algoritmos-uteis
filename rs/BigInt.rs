use std::fmt;
use std::ops::{Add, Mul, Sub};
use std::cmp::{Ord, Ordering, PartialOrd};


struct BigInt {
    sign: i8,
    digits: Vec<u8>,
}

impl BigInt {
    fn new(sign: i8, digits: Vec<u8>) -> BigInt {
        // Validação para garantir que o número não começa com zeros
        let mut digits = digits;
        while digits.len() > 1 && digits[0] == 0 {
            digits.remove(0);
        }
        BigInt { sign, digits }
    }

    fn from_str(s: &str) -> BigInt {
        let mut sign = 1;
        let mut digits = Vec::new();
        let mut start = 0;

        if s.starts_with('-') {
            sign = -1;
            start = 1;
        } else if s.starts_with('+') {
            start = 1;
        }

        for ch in s[start..].chars() {
            if ch.is_digit(10) {
                digits.push(ch as u8 - '0' as u8);
            } else {
                panic!("Invalid character in string");
            }
        }

        BigInt::new(sign, digits)
    }

    fn abs(&self) -> BigInt {
        BigInt::new(1, self.digits.clone())
    }

    fn and(&self, other: &BigInt) -> bool {
        self.cmp(other) == 0
    }

    fn or(&self, other: &BigInt) -> bool {
        self.cmp(other) != 0
    }
}

impl fmt::Display for BigInt {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if self.sign == -1 {
            write!(f, "-")?;
        }
        for d in &self.digits {
            write!(f, "{}", d)?;
        }
        Ok(())
    }
}

impl Add for BigInt {
    type Output = BigInt;

    fn add(self, other: BigInt) -> BigInt {
        if self.sign == other.sign {
            let mut result = BigInt::new(self.sign, Vec::new());
            let mut carry = 0;
            let mut i = 0;
            while i < self.digits.len() || i < other.digits.len() {
                let d1 = if i < self.digits.len() { self.digits[i] } else { 0 };
                let d2 = if i < other.digits.len() { other.digits[i] } else { 0 };
                let sum = d1 + d2 + carry;
                result.digits.push(sum % 10);
                carry = sum / 10;
                i += 1;
            }
            if carry > 0 {
                result.digits.push(carry);
            }
            result
        } else if self.abs() > other.abs() {
            BigInt::new(self.sign, self.sub(other).digits)
        } else {
            BigInt::new(other.sign, other.sub(self).digits)
        }
    }
}

impl Sub for BigInt {
    type Output = BigInt;

    fn sub(self, other: BigInt) -> BigInt {
        if self.sign == other.sign {
            if self.abs() >= other.abs() {
                let mut result = BigInt::new(self.sign, Vec::new());
                let mut borrow = 0;
                let mut i = 0;
                while i < self.digits.len() || i < other.digits.len() {
                    let d1 = if i < self.digits.len() { self.digits[i] } else { 0 };
                    let d2 = if i < other.digits.len() { other.digits[i] } else { 0 };
                    let diff = d1.wrapping_sub(d2).wrapping_sub(borrow);
                    if diff < 0 {
                        borrow = 1;
                        result.digits.push(diff + 10);
                    } else {
                        borrow = 0;
                        result.digits.push(diff);
                    }
                    i += 1;
                }
                result
            } else {
                BigInt::new(-other.sign, other.sub(self).digits)
            }
        } else if self.sign == 1 {
            BigInt::new(1, self.add(other.abs()).digits)
        } else {
            BigInt::new(-1, other.add(self.abs()).digits)
        }
    }
}

impl Mul for BigInt {
    type Output = BigInt;

    fn mul(self, other: BigInt) -> BigInt {
        let sign = if self.sign == other.sign { 1 } else { -1 };
        let mut result = BigInt::new(sign, vec![0; self.digits.len() + other.digits.len()]);
        for i in 0..self.digits.len() {
            let mut carry = 0;
            for j in 0..other.digits.len() {
                let d1 = self.digits[i];
                let d2 = other.digits[j];
                let mut product = result.digits[i + j] + d1 * d2 + carry;
                result.digits[i + j] = product % 10;
                carry = product / 10;
            }
            result.digits[i + other.digits.len()] += carry;
        }
        result
    }
}

impl PartialEq for BigInt {
    fn eq(&self, other: &BigInt) -> bool {
        self.cmp(other) == 0
    }
}

impl PartialOrd for BigInt {
    fn partial_cmp(&self, other: &BigInt) -> Option<Ordering> {
        match self.cmp(other) {
            0 => Some(Ordering::Equal),
            1 => Some(Ordering::Greater),
            -1 => Some(Ordering::Less),
            _ => None,
        }
    }
}

impl Ord for BigInt {
    fn cmp(&self, other: &BigInt) -> Ordering {
        match self.partial_cmp(other) {
            Some(ordering) => ordering,
            None => panic!("comparison failed"),
        }
    }
}




fn main() {
    let n = BigInt::from_str("12345");
    println!("{}", n);

    let m = BigInt::from_str("-98765");
    println!("{}", m);
}
