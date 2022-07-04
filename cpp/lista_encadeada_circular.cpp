typedef struct Nodo {
	bool data;
	Nodo *front;
	Nodo *back;
} Nodo;

class Lista_Circular{
	public:
		Nodo* cabeca;
		Nodo* atual;
	Lista_Circular(){
		this->cabeca = nullptr;
		this->atual = this->cabeca;
	}

	void inserir(bool data){
		if(this->cabeca == nullptr){
			this->cabeca = new Nodo;
			this->cabeca->front = this->cabeca;
			this->cabeca->back = this->cabeca;

			this->atual = this->cabeca;
			this->cabeca->data = data;
		}else{
			Nodo *nodo = new Nodo;
			nodo->data = data;
	
			nodo->front = this->cabeca;
			nodo->back = this->cabeca->back;
	
			this->cabeca->back->front = nodo;
			this->cabeca->back = nodo;
			this->atual = nodo;
		}
	}

	void proximo(){
		this->atual = this->atual->front;
	}

	void voltar(){
		this->atual = this->atual->back;
	}

	Nodo* get_atual(){
		return this->atual;
	}

	void voltar_inicio(){
		this->atual = this->cabeca;
	}
};