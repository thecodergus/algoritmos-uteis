fn verificar_se_eh_par(num: String) -> bool {
    let last_c: char = num.chars().last().unwrap();
    let pares: Vec<char> = Vec::from(['0', '2', '4', '6', '8']);
    
    return pares.contains(&last_c);
}