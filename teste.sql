
-- 01 Alterar o salário do empregado de código 3 para 28000.
UPDATE empresa.empregado SET salario = 28000
WHERE codEmp = 3;
-- 02 Obter nomes de empregados com salario > 30000.
SELECT nome FROM empresa.empregado WHERE salario > 30000;
-- 03 Obter nomes de empregados que trabalham no projeto 'Transmogrifador'.
SELECT empresa.empregado.nome FROM empresa.empregado INNER JOIN empresa.projeto
ON empresa.empregado.codDepto = empresa.projeto.codDepto
WHERE empresa.projeto.titulo = 'Transmogrifador';

-- 04 Obter nomes e endereços de todos os empregados que trabalham no
-- departamento de 'Pesquisa'. Use INNER JOIN para esta consulta.
SELECT empregado.nome, endereco FROM empresa.empregado INNER JOIN empresa.departamento
ON empregado.codDepto = departamento.codDepto
WHERE departamento.nome = 'Pesquisa';
-- 05 Obter nomes de empregados que começam com a letra 'A'. Dica: use LIKE.
SELECT nome FROM empresa.empregado
WHERE nome LIKE 'A%';
-- 07 Obter nome dos empregados em letra maiuscula
SELECT upper(nome) FROM empresa.empregado; 
-- 08 Alterar no nome dos empregados para letra maiuscula
UPDATE empresa.empregado SET nome = upper(nome);
-- 09 Obter o nome dos empregados com a letra inicial em maiusculo e as demais
--em minusculo
SELECT upper(substr(nome, 1, 1)) || lower(substr(nome,2,length(nome))) FROM empresa.empregado;
--10 Obter o empregado mais velho
SELECT nome FROM empresa.empregado
WHERE dataNasc = (SELECT MIN(dataNasc) FROM empresa.empregado);
--11 Obter o empregado mais novo
SELECT nome FROM empresa.empregado
WHERE dataNasc = (SELECT MAX(dataNasc) FROM empresa.empregado);
-- 12 Obter os nomes e datas de nascimento dos empregados que fazem aniversário
-- no mês de outubro.
-- http://www.postgresql.org/docs/9.3/static/functions-datetime.html  
SELECT nome, dataNasc FROM empresa.empregado
WHERE date_part('month', dataNasc) = 10;
-- 13 Obter os nomes dos empregados nascidos entre as datas 1950-01-01 e
--1970-01-01. Dica: use BETWEEN.
SELECT nome FROM empresa.empregado
WHERE dataNasc BETWEEN '1950-01-01' AND '1970-01-01';
--14 Listar os títulos de projetos em ordem alfabética. Dica: use ORDER BY
SELECT titulo FROM empresa.projeto
ORDER BY titulo;
--15 Listar nomes e horas trabalhadas por empregados no projeto de código 3,
-- em ordem decrescente de horas trabalhadas.
SELECT empregado.nome, trabalhaem.horas FROM empresa.empregado
INNER JOIN empresa.trabalhaem ON empregado.codemp = trabalhaem.codemp
WHERE trabalhaem.codproj = 3 ORDER BY horas DESC;
--16 Obter códigos de empregados que trabalham mais de 10 horas em algum projeto.
-- O resultado da consulta não deve ter repetições de códigos de empregados.
-- Dica: use DISTINCT.
SELECT DISTINCT empregado.codemp FROM empresa.empregado INNER JOIN empresa.trabalhaem 
ON trabalhaem.codemp = empregado.codemp WHERE horas > 10;
-- 17 Obter a quantidade de empregados pertencentes ao departamento 4.
-- Dica: consulte funções agregadas do SQL.
 SELECT COUNT(*) FROM empresa.empregado WHERE coddepto = 4;
 -- 18 Obter, a partir da tabela trabalhaEm, os números mínimo, máximo e médio de
-- horas trabalhadas por empregados em cada projeto.
-- O resultado deve possuir 4 colunas nomeadas: projeto, minimo, maximo e media.
-- Dica: use AS para renomear os campos e GROUP BY para agrupar os resultados
-- por projeto.
SELECT codproj AS projeto, MIN(horas) AS minimo, MAX(horas) AS maximo, SUM(horas)/COUNT(*) AS media
FROM empresa.trabalhaem GROUP BY codproj ORDER BY codproj;
-- 19 Obter os códigos de projetos cuja média de horas trabalhadas seja maior
-- que 20. Dica: use HAVING.
SELECT codproj FROM empresa.trabalhaem GROUP BY codproj HAVING SUM(horas)/COUNT(*) > 20;
-- 20 Obter os nomes de projetos correspondentes à consulta anterior.
-- Usar a consulta anterior como uma consulta aninhada à nova consulta.
-- Dica: use AS para evitar ambigüidades de nomes entre as consultas.
SELECT titulo FROM empresa.projeto 
WHERE empresa.projeto.codproj IN (SELECT codproj FROM empresa.trabalhaem GROUP BY codproj HAVING SUM(horas)/COUNT(*) > 20) ;

