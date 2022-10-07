using IterativeSolvers

function gauss_seidel1(a::Matrix{Number}, x::Vector{Number}, b::Vector{Number}, iter::Int64=1000)::Vector{Number}
    n::Int64 = length(b)

    for _ = 1:iter
        for i = 1:n
			# Como tava ontem:
            # x[i] = (b[i] - sum((a[i, :]' .* x)[:, 1]) + (a[i, i] * x[i])) / a[i, i]
			# Como ajustei hoje
			x[i] = (b[i] - ((a[i, :]' * x) - (a[i, i] * x[i]))) / a[i, i]
        end
    end

    return x
end

function gauss_seidel2(a::Matrix{Number}, x::Vector{Number}, b::Vector{Number}, iter::Int64=1000)::Vector{Number}
	n = length(b)

	for _ = 1:iter
		for j = 1:n
			d = b[j]

			for i = 1:n
				if i != j
					d -= a[j, i] * x[i]
				end
			end
			x[j] = d / a[j, j]
		end
	end

	return x
end

# Os 3 algoritmos
function main()
	a::Matrix{Number} = [4 1 2; 3 5 1; 1 1 3]
	b::Vector{Number} = [4, 7, 3]
	x::Vector{Number} = zeros(3)

	iter = 100
	
	println(gauss_seidel1(a, b, x, iter))
	println(gauss_seidel2(a, b, x, iter))
	println(IterativeSolvers.gauss_seidel!(x, a, b; maxiter = iter))
end

main()