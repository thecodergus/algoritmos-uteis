fn input () -> String{
    let mut ret = String::new();
    std::io::stdin().read_line(&mut ret).expect("Failed to read from stdin");

    ret
}