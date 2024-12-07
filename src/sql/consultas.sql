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
SELECT R.ID_Reserva, R.Data_Reserva, R.Instalacao, R.Nro_Espaco, R.Tipo_Reserva 
  FROM Reserva R 
  JOIN Reserva_Esportiva RE 
  ON R.Tipo_Reserva = 'RESERVA ESPORTIVA'
    AND R.Data_Reserva >= TRUNC(SYSDATE + 1)
    (SELECT U.Nome, F.F_ID, F.Nome
      FROM Usuaio U, Funcionario_Instalacao F 
      WHERE U.U_ID = RE.Usuario 
        AND F.F_ID = RE.Funcionario_Responsavel);

-- consulta 2: dado uma instalacao X, quais os usuarios que fizeram alguma reserva em todos os espacos esportivos de X
-- usuario -> reserva_esportiva -> reserva (usuario, numero_espaco) / instalacao_esportiva (X)-> Espaco_Esportivo (numero_espaco)
-- XXXXXXXXXXX = CNPJ Instalacao Esportiva
SELECT U.Nome, U.U_ID 
  FROM Usuario U
  WHERE NOT EXISTS (
    (SELECT Esp.Numero_Espaco FROM Espaco_Esportivo Esp WHERE Esp.CNPJ = 'XXXXXXXXXX') 
    EXCEPT 
    (SELECT R.Numero_Espaco
      FROM Usuario Ud JOIN Reserva_Esportiva RE ON RE.Usuario = Ud.U_ID
      JOIN Reserva R ON R.ID_Reserva = RE.ID_Reserva
      WHERE Ud.U_ID = U.U_ID AND R.Instalacao = 'XXXXXXXXXX'
    )
  );
