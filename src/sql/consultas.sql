-- script com as consultas realizadas no banco de dados já criado

-- ideias de consultas para se fazer:
  -- as reservas aprovadas por um funcionário X ou qual funcionário aprovou uma reserva X - join interno resolve
    -- se quiser acrescentar mais algo, é possível ver quem é o usuário responsável pelo resultado anterior - acho que outro join interno possa resolver

  -- todas as reservas feitas por um usuario específico, junto com as informações do espaço esportivo e instalação - acho que teria que ser uma consulta alinhada

  -- quais as instalações esportivas e cidades de um usuário X já fez reservas - para isso acho que seria necessario um join externo 
  
  -- quais contratos o gestor X realizou com uma empresa Y, ou com várias empresas - join interno

  -- Empresas responsáveis pelas manutenções que ainda não foram realizadas - consulta alinhada ?

  -- Exibir as cidades e os endereços das instalações esportivas que tem piscina - 2 joins internos

  -- buscar todas as reservas (esportivas e de manutenção) de um dia X - select 

-- consulta 1: saber qual o funcionário que aprovou e o usuário responsável por todas as reservas esportivas que ainda não ocorreram 
-- SELECT R.ID_Reserva, R.Data_Reserva, R.Instalacao, R.Nro_Espaco, R.Tipo_Reserva 
--     FROM Reserva R 
--     JOIN Reserva_Esportiva RE 
--     ON R.Tipo_Reserva = 'RESERVA ESPORTIVA'
--         AND R.Data_Reserva >= TRUNC(SYSDATE + 1)
--     (SELECT U.Nome, F.F_ID, F.Nome
--         FROM Usuaio U, Funcionario_Instalacao F 
--         WHERE U.U_ID = RE.Usuario 
--             AND F.F_ID = RE.Funcionario_Responsavel);





/* 
consulta 2: selecionar ID_Reserva, Hora inicio, Hora Termino, Data_Reserva, Instalacao, 
            Nro_Espaco, Tipo_Reserva, Nome_Instalacao, Nome_Cidade, Tipo_Espaco
de todas as reservas esportivas ou de manutenção feitas no ano corrente
*/
SELECT
    r.ID_Reserva,
    r.Data_Reserva,
    r.Hora_Inicio,
    r.Hora_Termino,
    r.Instalacao,
    r.Nro_Espaco,
    r.Tipo_Reserva,
    i.Nome AS Nome_Instalacao,
    c.Nome AS Nome_Cidade,
    e.Tipo AS Tipo_Espaco
FROM Reserva r
JOIN Instalacao_Esportiva i ON r.Instalacao = i.CNPJ
JOIN Cidade c ON i.Cidade = c.Codigo_Municipio
JOIN Espaco_Esportivo e ON r.Instalacao = e.Instalacao AND r.Nro_Espaco = e.Nro_Espaco
WHERE EXTRACT(YEAR FROM Data_Reserva) = EXTRACT(YEAR FROM SYSDATE);




-- consulta 3: dado uma instalacao X, quais os usuarios que fizeram alguma reserva em todos os espacos esportivos de X
-- usuario -> reserva_esportiva -> reserva (usuario, numero_espaco) / instalacao_esportiva (X)-> Espaco_Esportivo (numero_espaco)
-- XXXXXXXXXXX = CNPJ Instalacao Esportiva
SELECT U.Nome, U.U_ID 
  FROM Usuario U
  WHERE NOT EXISTS (
    (SELECT Esp.Nro_Espaco FROM Espaco_Esportivo Esp WHERE Esp.Instalacao = '47.267.698/0001-79') 
    MINUS 
    (SELECT R.Nro_Espaco
      FROM Usuario Ud JOIN Reserva_Esportiva RE ON RE.Usuario = Ud.U_ID
      JOIN Reserva R ON R.ID_Reserva = RE.ID_Reserva
      WHERE Ud.U_ID = U.U_ID AND R.Instalacao = '47.267.698/0001-79'
    )
  );


-- consulta 4: dado uma instalação esportiva XXX, ver quais servicos tiveram orcamento acima de YYY reais
-- Instalacao -> ~~Espaco~~ -> Reserva -> Manutencao -> Contrato (orcamento) -> Servico_Contrato (servico)
SELECT S.Servico, C.Orcamento, C.Empresa, C.ID_Contrato
  FROM Instalacao_Esportiva I 
  JOIN Reserva R ON R.Instalacao = I.CNPJ
  JOIN Manutencao M ON M.ID_Reserva = R.ID_Reserva
  JOIN Contrato C ON C.ID_Contrato = M.Contrato
  JOIN Servicos_Contrato S ON S.Contrato = C.ID_Contrato
  WHERE C.Orcamento > 40000 AND I.CNPJ = '98.765.432/0001-98';



-- consulta 5: ver quantas reservas funcionário fizeram (funcionário como usuário) (se nao fez reserva deve ficar com 0)
SELECT F.Nome, F.F_ID, count(R.ID_Reserva) as Reservas
  FROM Funcionario_Instalacao F LEFT JOIN Pessoa_Fisica P ON P.CPF = F.CPF
  LEFT JOIN Reserva_Esportiva R ON R.Usuario = P.U_ID
  GROUP BY F.F_ID, F.Nome;


-- consulta 6: Selecionar empresas responsáveis pelas manutenções que ainda não foram realizadas
-- usar o status da tabela manutençao que pode ser apenas ('MARCADA', 'EM ANDAMENTO', 'FINALIZADA', 'CANCELADA')
SELECT C.Empresa, M.Status
  FROM Contrato C 
  JOIN Manutencao M ON C.ID_Contrato = M.Contrato
  WHERE M.Status IN ('MARCADA', 'EM ANDAMENTO');


-- consulta 7: selecionar as cidades e os endereços das instalações esportivas que tem piscina
-- deixar o E.tipo em maiusculo para garantir que não haja erro de case
SELECT C.Nome, I.Endereco_Rua, I.Endereco_Numero, I.Endereco_Bairro, I.Endereco_CEP
  FROM Cidade C JOIN Instalacao_Esportiva I ON C.Codigo_Municipio = I.Cidade
  JOIN Espaco_Esportivo E ON I.CNPJ = E.Instalacao
  WHERE UPPER(E.Tipo) LIKE '%PISCINA%';
