using DataFrames, CSV, StringEncodings, Dates, LibPQ

"""
Constantes e Configurações
"""
const EMPRESAS = ["3Tentos", "Monsanto", "SLC", "Mosaic"]
const ANOS = [2023, 2024]
const TIPOS_ARQUIVO = [
    "Impo_Adicoes",
    "Impo_Dis",
    "Impo_Mercadorias",
    "SPED_Contribuicoes",
    "SPED_Fiscal"
]

# Configurações do Banco de Dados
const DB_CONFIG = "host=localhost dbname=n8n user=gus password=gus"
const BATCH_SIZE = 1000

# Limites do PostgreSQL
const PG_INTEGER_MIN = -2147483648
const PG_INTEGER_MAX = 2147483647
const PG_BIGINT_MIN = -9223372036854775808
const PG_BIGINT_MAX = 9223372036854775807

"""
Normaliza nome da coluna
"""
function normalize_column_name(name::String)
    # Remove caracteres especiais e converte para lowercase
    cleaned = lowercase(replace(string(name), r"[^a-zA-Z0-9_]" => "_"))
    # Remove underscores duplicados
    cleaned = replace(cleaned, r"_+" => "_")
    # Remove underscores no início e fim
    return strip(cleaned, '_')
end

"""
Determina tipo PostgreSQL para uma coluna
"""
function determine_postgresql_type(col::AbstractVector, column_name::String)
    # Campos de origem são sempre TEXT NOT NULL
    if column_name in ["empresa_origem", "ano_origem"]
        return "TEXT NOT NULL"
    end

    # Verifica se é obrigatório
    has_values = !all(ismissing, col)
    is_required = !any(ismissing, col)
    nullable_suffix = is_required ? " NOT NULL" : ""

    # Campos COD_ são sempre TEXT
    if startswith(uppercase(column_name), "COD_")
        return "TEXT" * nullable_suffix
    end

    if !has_values
        return "TEXT"
    end

    base_type = nonmissingtype(eltype(col))

    # Determina tipo SQL baseado no tipo Julia
    if base_type <: Integer
        non_missing_values = collect(skipmissing(col))

        if isempty(non_missing_values)
            return "INTEGER"
        end

        max_val = maximum(non_missing_values)
        min_val = minimum(non_missing_values)

        if PG_INTEGER_MIN <= min_val <= max_val <= PG_INTEGER_MAX
            return "INTEGER" * nullable_suffix
        elseif PG_BIGINT_MIN <= min_val <= max_val <= PG_BIGINT_MAX
            return "BIGINT" * nullable_suffix
        else
            return "TEXT" * nullable_suffix
        end
    elseif base_type <: AbstractFloat
        return "NUMERIC" * nullable_suffix
    elseif base_type <: Bool
        return "BOOLEAN" * nullable_suffix
    elseif base_type <: Dates.TimeType
        return "TIMESTAMP" * nullable_suffix
    else
        return "TEXT" * nullable_suffix
    end
end

"""
Prepara valor para inserção SQL
"""
function prepare_value_for_sql(value)
    if ismissing(value)
        return "NULL"
    elseif value isa AbstractString
        # Escapa aspas simples e remove caracteres problemáticos
        cleaned = replace(value, "'" => "''")
        cleaned = replace(cleaned, r"[\x00-\x1F\x7F]" => "")
        return "'" * cleaned * "'"
    elseif value isa Bool
        return value ? "TRUE" : "FALSE"
    elseif value isa Dates.TimeType
        return "'" * string(value) * "'"
    else
        return string(value)
    end
end

"""
Processa e valida DataFrame antes da inserção
"""
function preprocess_dataframe!(df::DataFrame)
    println("\n🔍 Pré-processando DataFrame...")

    # Normaliza nomes das colunas
    new_names = [normalize_column_name(string(col)) for col in names(df)]
    rename!(df, Dict(zip(names(df), Symbol.(new_names))))

    # Remove colunas problemáticas conhecidas
    problematic_columns = [:cnpj_import, :dat_di, :num_adicoes]
    removed_columns = String[]

    for col in problematic_columns
        if col in Symbol.(names(df))
            select!(df, Not(col))
            push!(removed_columns, string(col))
        end
    end

    # Remove colunas que começam com ?
    invalid_cols = filter(col -> startswith(string(col), "?"), names(df))
    if !isempty(invalid_cols)
        select!(df, Not(invalid_cols))
        append!(removed_columns, string.(invalid_cols))
    end

    if !isempty(removed_columns)
        println("⚠️ Colunas removidas: ", join(removed_columns, ", "))
    end

    println("✅ Pré-processamento concluído")
    return df
end

"""
Insere dados em lotes
"""
function batch_insert_data(conn::LibPQ.Connection, df::DataFrame, table_name::String)
    try
        df = preprocess_dataframe!(df)
        total_rows = nrow(df)
        df_columns = string.(names(df))

        println("\n📥 Iniciando inserção em lotes...")

        for batch_start in 1:BATCH_SIZE:total_rows
            batch_end = min(batch_start + BATCH_SIZE - 1, total_rows)
            batch = df[batch_start:batch_end, :]

            values_strings = String[]
            for row in eachrow(batch)
                values = [prepare_value_for_sql(row[col]) for col in names(df)]
                push!(values_strings, "(" * join(values, ", ") * ")")
            end

            sql = """
            INSERT INTO $(lowercase(table_name)) ($(join(df_columns, ", ")))
            VALUES $(join(values_strings, ",\n"))
            """

            try
                LibPQ.execute(conn, sql)
                println("✅ Lote $(batch_start)-$(batch_end) inserido")
            catch e
                handle_insertion_error(e, df, table_name)
            end
        end

        println("\n✅ Inserção concluída. Total: $total_rows registros")
    catch e
        println("\n❌ Erro fatal durante inserção:")
        println(e)
        rethrow(e)
    end
end

"""
Trata erros de inserção
"""
function handle_insertion_error(e, df::DataFrame, table_name::String)
    if occursin("column", string(e)) && occursin("does not exist", string(e))
        column_match = match(r"column \"([^\"]+)\"", string(e))
        if !isnothing(column_match)
            problematic_column = Symbol(column_match.captures[1])
            println("\n⚠️ Coluna problemática detectada: '$(problematic_column)'")
            if problematic_column in Symbol.(names(df))
                select!(df, Not(problematic_column))
                return batch_insert_data(conn, df, table_name)
            end
        end
    end
    println("\n❌ Erro de inserção:")
    println(e)
    rethrow(e)
end

"""
Carrega e processa arquivo CSV
"""
function process_csv_file(conn::LibPQ.Connection, filepath::String, empresa::String, ano::String, table_name::String)
    println("\n📂 Processando: $filepath")

    try
        df = CSV.read(open(filepath, enc"LATIN1"), DataFrame)
        df[!, :empresa_origem] .= empresa
        df[!, :ano_origem] .= ano

        batch_insert_data(conn, df, lowercase(table_name))
        println("✅ Arquivo processado com sucesso!")
    catch e
        println("❌ Erro ao processar arquivo:")
        println(e)
        for (exc, bt) in Base.catch_stack()
            showerror(stdout, exc, bt)
            println()
        end
    end
end

"""
Função principal
"""
function upload_data_to_postgresql()
    conn = nothing

    try
        conn = LibPQ.Connection(DB_CONFIG)
        println("✅ Conectado ao PostgreSQL")

        # Processa BOMs
        for empresa in EMPRESAS
            bom_path = joinpath("BOMs", "$(empresa)_BOMs.csv")
            isfile(bom_path) && process_csv_file(conn, bom_path, empresa, "NA", "boms")
        end

        # Processa outros arquivos
        for tipo in TIPOS_ARQUIVO
            for empresa in EMPRESAS, ano in ANOS
                arquivo_path = joinpath("$(empresa)_$(ano)", "$(empresa)_$(ano)_$(tipo).csv")
                isfile(arquivo_path) && process_csv_file(conn, arquivo_path, empresa, string(ano), tipo)
            end
        end

        println("\n✨ Processamento concluído com sucesso!")
    catch e
        println("\n❌ Erro durante processamento:")
        println(e)
    finally
        conn !== nothing && close(conn)
    end
end

# Executa o processo
upload_data_to_postgresql()
