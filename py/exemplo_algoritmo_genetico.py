import numpy as np, pygad

# Modelo numerico
def equation_func(ga_instance, solution, solution_idx):
    x = solution[0]
    equation_output = 2 * x + 5
    target_output = 20
    fitness = 1.0 / np.abs(equation_output - target_output + 1e-8)

    return fitness


ga_instance = pygad.GA(
    100,
    num_parents_mating=10,
    fitness_func=equation_func,
    sol_per_pop=20,
    num_genes=1,
    gene_type=float,
    init_range_low=-10,
    init_range_high=10,
)
ga_instance.run()
solution, solution_fitness, _ = ga_instance.best_solution()
print(f"Melhor solução: {solution}")
print(f"Pontos: {solution_fitness}")

# Modelo binario

itens = [
    ("canivete", 10, 1),
    ("feijão", 20, 5),
    ("batatas", 15, 10),
    ("lanterna", 2, 1),
    ("saco de dormir", 30, 7),
    ("corda", 10, 5),
    ("bussula", 30, 1),
]

limite_peso = 15


def fitness_func(ga_instace, solution, solution_idx):
    pontos = 0
    peso = 0
    for i in range(len(solution)):
        if solution[i] == 1:
            pontos += itens[i][1]
            peso += itens[i][2]

    if peso > limite_peso:
        return -1
    else:
        return pontos


ga_instance = pygad.GA(
    100,
    num_parents_mating=5,
    fitness_func=fitness_func,
    sol_per_pop=10,
    num_genes=len(itens),
    gene_type=int,
    init_range_low=0,
    init_range_high=2,  # Na pratica 1
)

ga_instance.run()
solution, solution_fitness, _ = ga_instance.best_solution()
print(f"Melhor solução: {solution}")
print(f"Pontos: {solution_fitness}")