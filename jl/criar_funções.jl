via funcao macro
macro expr2fn(fname, expr, args...)
    fn = quote
        function $(esc(fname))()
            $(esc(expr.args[1]))
        end
    end
    for arg in args
        push!(fn.args[2].args[1].args, esc(arg))
    end
    return fn
end

# De string (função simples)
function criar_função(f::String)::Function
    return @eval x -> $(f |> Meta.parse)
end
