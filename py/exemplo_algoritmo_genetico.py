import numpy as np, pygad

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