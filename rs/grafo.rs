use std::{cell::RefCell, rc::Rc, collections::HashMap};



struct Vertice {
    nome: String,
    vizinhos: Vec<Rc<RefCell<Vertice>>>
}

impl Vertice{
    fn new(nome: String) -> Self{
        Vertice { nome, vizinhos: vec![] }
    }
}

fn criar_vertice(nome: String) -> Rc<RefCell<Vertice>> {
    Rc::new(RefCell::new(Vertice::new(nome)))
}


fn main() {
    let mut vertices: HashMap<String, Rc<RefCell<Vertice>>> = HashMap::new();
    let nome1 = String::from("nome1");
    let nome2 = String::from("nome2");

    if vertices.contains_key(&nome1){
        vertices.insert(nome1.clone(), criar_vertice(nome1.clone()));
    }

    if vertices.contains_key(&nome2){
        vertices.insert(nome2.clone(), criar_vertice(nome2.clone()));
    }

    vertices.get(&nome1).unwrap().borrow_mut().vizinhos.push(vertices.get(&nome2).unwrap().clone());
    vertices.get(&nome2).unwrap().borrow_mut().vizinhos.push(vertices.get(&nome1).unwrap().clone());
}
