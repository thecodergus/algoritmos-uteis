create or replace function getNumeroEmpregados(id int) returns bigint as
$$
    select count(*) from empregado as e10
        inner join divisao as d10 on e10.lotacao_div = d10.cod_divisao
        where
        d10.cod_dep = id
$$
language sql;

create or replace function getDescontoEmpregado(id int) returns numeric as
$$
    select
        round(coalesce(sum(d20.valor), 0), 2) as valor from desconto as d20
        inner join emp_desc as ed20 on d20.cod_desc = ed20.cod_desc
        where ed20.matr = id
$$
language sql;

create or replace function getSalarioEmpregado(id int) returns numeric as
$$
    select 
        coalesce(sum(v30.valor), 0)  - (select
        coalesce(sum(d20.valor), 0) as valor from desconto as d20
        inner join emp_desc as ed20 on d20.cod_desc = ed20.cod_desc
        where ed20.matr = id)
        as valor
        from vencimento as v30 
            inner join emp_venc as ev30 on v30.cod_venc = ev30.cod_venc
            inner join empregado as e30 on ev30.matr = e30.matr
            where e30.matr =  id
$$
language sql;

create or replace function getMediaSalarial(id int) returns numeric as
$$ e40.matr
    select round(sum(select 
        coalesce(sum(v30.valor), 0)  - (select
        coalesce(sum(d20.valor), 0) as valor from desconto as d20
        inner join emp_desc as ed20 on d20.cod_desc = ed20.cod_desc
        where ed20.matr = e40.mtr)
        as valor
        from vencimento as v30 
            inner join emp_venc as ev30 on v30.cod_venc = ev30.cod_venc
            inner join empregado as e30 on ev30.matr = e30.matr
            where e30.matr =  e40.mtr) / (select count(*) from empregado as e10
        inner join divisao as d10 on e10.lotacao_div = d10.cod_divisao
        where
        d10.cod_dep = e40.mtr), 2)  from empregado as e40
        inner join divisao as d40 on e40.lotacao_div = d40.cod_divisao
        where
        d40.cod_dep = id
$$
language sql;

create or replace function getMaiorSalario(id int) returns numeric as
$$ e50.matr
    select round(max(select 
        coalesce(sum(v30.valor), 0)  - (select
        coalesce(sum(d20.valor), 0) as valor from desconto as d20
        inner join emp_desc as ed20 on d20.cod_desc = ed20.cod_desc
        where ed20.matr = e50.matr)
        as valor
        from vencimento as v30 
            inner join emp_venc as ev30 on v30.cod_venc = ev30.cod_venc
            inner join empregado as e30 on ev30.matr = e30.matr
            where e30.matr =  e50.matr), 2) from empregado as e50
        inner join divisao as d50 on e50.lotacao_div = d50.cod_divisao
        where
        d50.cod_dep = id
$$
language sql;

create or replace function getMenorSalario(id int) returns numeric as
$$
    select round(min(select 
        coalesce(sum(v30.valor), 0)  - (select
        coalesce(sum(d20.valor), 0) as valor from desconto as d20
        inner join emp_desc as ed20 on d20.cod_desc = ed20.cod_desc
        where ed20.matr = e50.matr)
        as valor
        from vencimento as v30 
            inner join emp_venc as ev30 on v30.cod_venc = ev30.cod_venc
            inner join empregado as e30 on ev30.matr = e30.matr
            where e30.matr =  e50.matr), 2) from empregado as e50
        inner join divisao as d50 on e50.lotacao_div = d50.cod_divisao
        where
        d50.cod_dep = id
$$
language sql;


create or replace view resultado as
    select 
        dep.nome as "Nome Departamento",
        (getNumeroEmpregados(dep.cod_dep))::integer as "Numero de Empregados",
        round(getMediaSalarial(dep.cod_dep)::numeric, 2) as "Media Salarial",
        round(getMaiorSalario(dep.cod_dep)::numeric, 2) as "Maior Salario",
        round(getMenorSalario(dep.cod_dep)::numeric, 2) as "Menor Salario"
    from departamento as dep order by "Media Salarial" desc;

    
select * from resultado;
