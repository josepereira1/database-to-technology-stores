USE BracaTECH;

DROP PROCEDURE IF EXISTS  top_freguesias;
DROP PROCEDURE IF EXISTS  top_clientes_que_mais_gastaram;
DROP PROCEDURE IF EXISTS  top_clientes_com_mais_compras;
DROP PROCEDURE IF EXISTS  n_produtos_menos_stock;
DROP PROCEDURE IF EXISTS  clientes_de;
DROP PROCEDURE IF EXISTS  n_produtos_mais_comprados;
DROP PROCEDURE IF EXISTS  n_servicos_mais_recorridos;
DROP PROCEDURE IF EXISTS  nr_vendas_feitas_em;
DROP PROCEDURE IF EXISTS  nr_servicos_feitos_em;
DROP PROCEDURE IF EXISTS  nr_servicos_feitos_por_cada_funcionario;
DROP PROCEDURE IF EXISTS nr_vendas_feitas_por_cada_funcionario;
DROP PROCEDURE IF EXISTS top_clientes_com_mais_descontos;
DROP PROCEDURE IF EXISTS classificacao_geral;
DROP PROCEDURE IF EXISTS vendas_do_dia;
DROP PROCEDURE IF EXISTS valor_em_salarios;
DROP PROCEDURE IF EXISTS procurar_por_telefone_cliente;
DROP PROCEDURE IF EXISTS  produtos_comprados_cliente;
DROP PROCEDURE IF EXISTS mostra_info_produtos_venda;

-- #1 - top N freguesias
DELIMITER $$
CREATE PROCEDURE top_freguesias(IN nr INT)
BEGIN
  SELECT Cliente.freguesia, COUNT(Cliente.freguesia) AS Numero 
  	FROM Cliente
  		GROUP BY Cliente.freguesia
  			ORDER BY Numero DESC
  				LIMIT nr;
END $$
DELIMITER ; 


-- #2 TOP N CLIENTES QUE MAIS GASTARAM
DELIMITER $$
CREATE PROCEDURE top_clientes_que_mais_gastaram(IN nr INT)
BEGIN
   SELECT Cliente.nif, Cliente.nome_completo, Cliente.valor_total_gasto AS ValorGasto 
   		FROM Cliente
   			ORDER BY ValorGasto DESC
   				LIMIT nr;	
END $$
DELIMITER ; 

-- #3 N PRODUTOS COM MENOS STOCK
DELIMITER $$
CREATE PROCEDURE n_produtos_menos_stock(IN nr INT)
BEGIN
   SELECT Produto.id, Produto.designacao, Produto.stock 
   		FROM Produto
			ORDER BY Produto.stock ASC
				LIMIT nr;
END $$
DELIMITER ;


-- #4 N PRODUTOS MAIS COMPRADOS
DELIMITER $$
CREATE PROCEDURE n_produtos_mais_comprados(IN n INT)
BEGIN
	SELECT VendaProduto.id_produto, Produto.designacao, SUM(VendaProduto.quantidade) AS VEZES 
		FROM VendaProduto 
    		INNER JOIN Produto
				ON VendaProduto.id_produto = Produto.id
					GROUP BY VendaProduto.id_produto
						ORDER BY VEZES DESC
							LIMIT n;
END $$
DELIMITER ; 


-- #5 QUANTAS VENDAS FORAM FEITAS NUM ANO
DELIMITER $$
CREATE PROCEDURE nr_vendas_feitas_em(IN ano VARCHAR(5))
BEGIN
	SELECT  COUNT(Venda.id) AS Vendas 
		FROM Venda
			WHERE YEAR (Venda.data_venda) = ano;
END $$
DELIMITER ; 


-- #6 QUANTOS SERVIÇOS FORAM FEITOS POR UM FUNCIONÁRIO EM DETERMINADO ANO
DELIMITER $$
CREATE PROCEDURE nr_servicos_feitos_por_cada_funcionario(IN ano VARCHAR(5))
BEGIN
	SELECT  Servico.id_funcionario, Funcionario.nome_completo as Nome, COUNT(Servico.id_funcionario) AS Servicos 
		FROM Servico
			INNER JOIN Funcionario
				ON Servico.id_funcionario = Funcionario.id
					WHERE YEAR(Servico.data_fim) = ano
						GROUP BY Servico.id_funcionario;
END $$
DELIMITER ; 


-- #7 QUANTAS VENDAS FORAM FEITAS POR CADA FUNCIONARIO NUM DETERMINADO ANO.
DELIMITER $$
CREATE PROCEDURE nr_vendas_feitas_por_cada_funcionario(IN ano VARCHAR(5))
BEGIN
	SELECT Venda.id_funcionario, Funcionario.nome_completo as Nome ,COUNT(Venda.id_funcionario) AS Vendas
		FROM Venda
			INNER JOIN Funcionario
				ON Venda.id_funcionario = Funcionario.id
					WHERE YEAR(Venda.data_venda) = ano
						GROUP BY Venda.id_funcionario;
END $$
DELIMITER ;


-- #8 MOSTRA OS N CLIENTES COM MAIS VALORES EM DESCONTOS
DELIMITER $$
CREATE PROCEDURE top_clientes_com_mais_descontos(IN limite INT)
BEGIN
	SELECT Cliente.nif, Cliente.nome_completo as Nome, Cliente.valor_total_descontos 
		FROM Cliente 
			ORDER BY Cliente.valor_total_descontos DESC 
				LIMIT limite;
END $$
DELIMITER ;


-- #9 CALCULA A CLASSIFICAÇÃO GERAL DOS CLIENTES
DELIMITER $$
CREATE PROCEDURE classificacao_geral ()
BEGIN
    SELECT AVG(Cliente.classificacao) AS classificacao_dos_clientes 
    	FROM Cliente 
    		WHERE Cliente.classificacao IS NOT NULL OR Cliente.classificacao != 0;
END $$
DELIMITER ; 


-- #10 MOSTRA AS VENDAS DO DIA
DELIMITER $$
CREATE PROCEDURE vendas_do_dia()
BEGIN
		SELECT * FROM Venda 
			WHERE DATE(Venda.data_venda) = DATE(NOW());
END $$
DELIMITER ;


-- #11 VALOR TOTAL EM SALARIOS NA LOJA BRACATECH
DELIMITER $$
CREATE PROCEDURE valor_em_salarios()
BEGIN
	SELECT SUM(Funcionario.salario) as Valor_total_em_salarios 
		FROM Funcionario;
END $$
DELIMITER ;


-- #12 PROCURAR UM CLIENTE PELO SEU NÚMERO DE TELEFONE
DELIMITER $$
CREATE PROCEDURE procurar_por_telefone_cliente(IN nr INT)
BEGIN	
    SELECT nif, nome_completo, sexo, data_nasc, email, estado_prof , 
    	   cod_postal, cidade, freguesia, rua , nr_telefone, tipo 
    	FROM Cliente
			INNER JOIN ClienteTelefone ON Cliente.nif = ClienteTelefone.nif_cliente
				WHERE ClienteTelefone.nr_telefone = nr;
END $$
DELIMITER ;

-- #13 - INFORMAÇÃO TODOS OS PRODUTOS COMPRADOS PELO CLIENTE
DELIMITER $$
CREATE PROCEDURE produtos_comprados_cliente(IN nif INT)
BEGIN
	SELECT Venda.id AS id_venda, Venda.data_venda, VendaProduto.id_produto, 
		   VendaProduto.quantidade,VendaProduto.preco_unitario_final, 
		   VendaProduto.preco_total, Produto.designacao, Produto.descricao,Produto.categoria 
		FROM Venda 
			INNER JOIN VendaProduto ON Venda.id = VendaProduto.id_venda
				INNER JOIN Produto ON VendaProduto.id_produto = Produto.id
						WHERE Venda.nif_cliente = nif
								ORDER BY Venda.id ASC;
END $$
DELIMITER ;


-- #14 DETALHAR INFORMAÇÃO DOS PRODUTOS DA VENDA
DELIMITER $$
CREATE PROCEDURE mostra_info_produtos_venda(IN id_venda INT)
BEGIN
	SELECT VendaProduto.id_produto, VendaProduto.preco_unitario_final, 
	VendaProduto.quantidade, VendaProduto.preco_total, Produto.designacao, Produto.descricao, Produto.categoria 
		FROM VendaProduto 
			INNER JOIN Produto
				ON VendaProduto.id_produto = Produto.id
					WHERE VendaProduto.id_venda = id_venda
						ORDER BY VendaProduto.preco_unitario_final DESC;	
END $$
DELIMITER ;

-- #15 QUAL O VALOR EM DESCONTOS ADQUIRIDO PELOS CLIENTES
SELECT SUM(Cliente.valor_total_descontos) 
	FROM Cliente;



