function gauss_seidel(a::Matrix{Number}, x::Vector{Number}, b::Vector{Number}, iter::Int64=1000)::Vector{Number}
    n::Int64 = length(b)

    for _ = 1:iter
        for i = 1:n
            x[i] = (b[i] - sum(a[i, :]' .* x) + a[i, i] * x[i]) / a[i, i]
        end
    end

    return x
end

a::Matrix{Number} = [4 1 2; 3 5 1; 1 1 3]
b::Vector{Number} = [4, 7, 3]
x::Vector{Number} = zeros(3)

println(x)
println(gauss_seidel(a, b, x))