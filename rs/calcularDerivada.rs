// Calcular Derivada
use std::rc::Rc;

#[macro_export]
macro_rules! func {
    ($e:expr) => (Rc::new($e) as Function);
}

type Function = Rc<dyn Fn(f64) -> f64>;

static EPSILON: f64 = 5.0e-7;

fn df(f: &Function, n: u64) -> Function {	
	let f_copy = f.clone();
	let deriv: Function = func!(
		move |x: f64| {
			(f_copy(x + EPSILON) - f_copy(x - EPSILON)) / (EPSILON * 2_f64)
	});

	match n {
		0 => f.clone(),
		1 => deriv,
		_ => df(&deriv, n - 1),
	}
}

fn main(){
    let f: fn(f64) -> f64{
        x.powi(4)
    };

    // Primeira Derivada
    let df1: Function = df(&func!(f), 1);

    // Segunda Derivada
    let df2: Function = df(&func!(f), 2);
}