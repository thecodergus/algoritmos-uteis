using Symbolics

# Escopo de variaveis usadas
@variables x

# Definindo função
f = x^3 + x^2 + x

# Geração função generica da derivada da função f sobre a variavel x
df = @eval $(build_function(expand_derivatives(Differential(x)(f)), x))