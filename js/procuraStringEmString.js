const searchByString = currentSearch => {
    const result = [];

    [...data].map((item, indexo) => {
        if (item.nivel.search(currentSearch) > -1) result.push(item)
    })

    setPreenchimentoTable(gerenciarDados(
        result
    ))
}
