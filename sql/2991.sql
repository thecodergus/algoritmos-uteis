create or replace function getNumeroEmpregados(id int) returns int as
$$
    select count(*) from empregado as e
        inner join divisao as d on e.lotacao_div = d.cod_divisao
        where
        d.cod_dep = id
$$
language sql;

create or replace function getMediaSalarial(id int) returns float as
$$
    select sum(getSalarioEmpregado(e.matr)) / getNumeroEmpregados(id)  from empregado as e
        inner join divisao as d on e.lotacao_div = d.cod_divisao
        where
        d.cod_dep = id
$$
language sql;

create or replace function getDescontoEmpregado(id int) returns float as
$$
    select
        coalesce(sum(d.valor), 0) as valor from desconto as d
        inner join emp_desc as ed on d.cod_desc = ed.cod_desc
        where ed.matr = id
$$
language sql;

create or replace function getSalarioEmpregado(id int) returns float as
$$
    select 
        coalesce(sum(v.valor), 0)  - getDescontoEmpregado(id)
        as valor
        from vencimento as v 
            inner join emp_venc as ev on v.cod_venc = ev.cod_venc
            inner join empregado as e on ev.matr = e.matr
            where e.matr =  id
$$
language sql;

create or replace function getMaiorSalario(id int) returns float as
$$
    select max(getSalarioEmpregado(e.matr)) from empregado as e
        inner join divisao as d on e.lotacao_div = d.cod_divisao
        where
        d.cod_dep = id
$$
language sql;

create or replace function getMenorSalario(id int) returns float as
$$
    select min(getSalarioEmpregado(e.matr)) from empregado as e
        inner join divisao as d on e.lotacao_div = d.cod_divisao
        where
        d.cod_dep = id
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
