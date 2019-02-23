-- ------------------------------------------------------
-- ------------------------------------------------------
-- Universidade do Minho
-- Mestrado Integrado em Engenharia Informática
-- Unidade Curricular de Bases de Dados
-- 
-- Caso de Estudo:A loja BracaTECH
-- Povoamento inicial da base de dados
-- Novembro/2018
-- ------------------------------------------------------
-- ------------------------------------------------------

--
-- Esquema: "BracaTECH"
USE BracaTECH;

--
-- Permissão para fazer operações de remoção de dados.
SET SQL_SAFE_UPDATES = 0;

--
-- Apagar as tabelas POR ESTA ORDEM para re-popular as tabelas com sucesso (caso contrário não deixa)
DELETE FROM VendaProduto;
DELETE FROM Produto;
DELETE FROM Servico;
DELETE FROM Venda;
DELETE FROM ClienteTelefone;
DELETE FROM Cliente;
DELETE FROM FuncionarioTelefone;
DELETE FROM Funcionario;
    
--
-- Povoamento da tabela "Funcionario"
INSERT INTO Funcionario
    (id, nome_completo, tipo, sexo, data_nascimento, data_registo_perfil, valor_total_vendas, salario, email, codigo_postal, cidade, freguesia, rua)
    VALUES
        (1, 'Ricardo André Gomes Petronilho', 'n', 'M', '1998-06-29', '2017-10-28 14:50:38', 0, 1850, 'rpetronilho@gmail.com', '4715-338',  'Braga', 'Fraião', 'Travessa da Quinta'),
        (2, 'José André Martins Pereira', 'a', 'M', '1997-06-19 ', '2017-02-10 09:42:12', 0, 4300, 'jose@gmail.com', '1234-567',  'Braga', 'Vilarinho', 'Rua da Mesericórdia'),
        (3, 'Maria Moreira', 'n', 'F', '1988-11-03', '2018-01-18 10:38:21', 0, 1450, 'mariamoreira@gmail.com', '8141-628',  'Vila Real', 'Nogueira', 'Rua da Horta'),
        (4, 'Pedro Pereira', 'n', 'M', '1990-04-12', '2016-09-20 17:16:56', 0, 2000, 'pmoreira@gmail.com', '6106-317',  'Porto', 'Moreira', 'Rua da Gandra'),
        (5, 'António Gomes', 'a', 'M', '1978-07-07', '2015-03-10 13:20:15', 0, 3775, 'agomes@gmail.com', '1051-946',  'Bragança', 'Lamacaes', 'Travessa da Poça');

--
-- Povoamento da tabela "FuncionarioTelefone"
INSERT INTO FuncionarioTelefone
    (nr_telefone, tipo, id_funcionario)
    VALUES
        ('912345678', 'M', 1),
        ('227013691', 'F', 2),
        ('967104827', 'M', 2),
        ('921057394', 'M', 3),
        ('931824729', 'M', 3),
        ('226194771', 'F', 4),
        ('915788165', 'M', 5);
        
--
-- Povoamento da tabela "Cliente"
INSERT INTO Cliente
    (nif, nome_completo , sexo, valor_total_descontos, valor_total_gasto, data_nascimento, data_registo_perfil, email, profissao, codigo_postal, cidade, freguesia, rua,classificacao)
    VALUES
    (748637829,'Miguel Nuno Martins Oliveira', 'M',0,0,'1997-11-22','2016-5-31','mnunooliveira@gmail.com', 'Canalizador', '4715-500','Braga', 'Gualtar', 'Rua da Borga',NULL),
    (849677721,'Filipe André Gomes', 'M',0,0,'1990-01-01','2017-02-23','filipegomes@gmail.com', 'Médico', '4715-315','Braga', 'Real', 'Rua da Escada',8),
    (815577721,'Maria José do Carmo', 'F',0,0,'1991-02-02','2017-12-01','mariacarmo@gmail.com', 'Enfermeira', '4715-200','Braga', 'Nogueira', 'Rua da Pedra',9),
    (201231323,'Elisabeth Oliveira Lopes', 'F',0,0,'1945-08-20','2017-12-15','bethlopes@gmail.com', 'Auxiliar infantil', '4700-400','Braga', 'Dume', 'Rua 31 de Janeiro',6),
    (214512313,'Gabriela Maria Soares', 'F',0,0,'2000-10-27','2017-12-21','gabrielasoares@gmail.com', 'Cantora', '4700-251','Braga', 'Real', 'Rua das Flores',7),
    (215343432,'Diogo Manuel Queirós', 'M',0,0,'1946-11-13','2017-12-22','diogoqueiros@gmail.com', 'Engenheiro Civil', '4700-400','Braga', 'Merelim', 'Rua Padre João',10),
    (218765545,'José Miguel Ferraz', 'M',0,0,'1996-08-12','2017-12-23','joseferraz@gmail.com', 'Agricultor', '4700-410','Braga', 'Sequeira', 'Rua das Camélias',8),
    (223456343,'Joana Dinis Cunha', 'F',0,0,'1987-10-13','2017-12-23','joanacunha@gmail.com', 'Polícia', '4700-420','Braga', 'Fraião', 'Rua do Alívio',7),
    (219765454,'João Ribeira Freitas', 'M',0,0,'1998-12-13','2017-12-24','joaofreitas@gmail.com', 'Advogado', '4700-430','Braga', 'S.Memede', 'Rua do Loureiro',5);
    

--
-- Povoamento da tabela "ClienteTelefone"
INSERT INTO ClienteTelefone
    (nr_telefone, tipo, nif_cliente)
    VALUES
    ('918713571', 'M', 748637829),
    ('253411719', 'F', 748637829),
    ('931938561', 'M', 849677721),
    ('934567343', 'M', 214512313),
    ('963332324', 'M', 201231323),
	('929875432', 'M', 215343432),
	('935665657', 'M', 218765545),
	('965757575', 'M', 223456343),
	('920865454', 'M', 219765454);
        
--
-- Povoamento da tabela "Produto"
INSERT INTO Produto
    (id, designacao, descricao, categoria, stock, preco_unitario, desconto)
    VALUES
    (1, 'Macbook Air - Edição 2018', 'Especificações:Processador i7-5400;8GB de RAM; 256GB de SSD;Ecrã Retina;OSX','Computadores', 1000, 1500, 0),
    (2, 'Macbook Pro - Edição 2018', 'Especificações:Processador i9-7400;16GB de RAM; 1024GB de SSD;Ecrã Retina;OSX','Computadores', 3000, 3000,0),
    (3, 'Notebook Asus', 'Especificações:Processador i5-7400;6GB de RAM; 1000GB de Disco;NVDIA GTX 1050Ti;Windows 10','Computadores', 500, 759, 0.1),
    (4, 'Portátil HP', 'Especificações:Processador i7-5400;16GB de RAM; 1000GB de Disco;GeoForce NVDIA GTX 1080;Windows 10','Computadores', 1300, 2000, 0),
    (5, 'RAM HYPREX', 'Especificações: Read: 500 MB/s; Write: 500 MB/s', 'Armazenamento', 500, 70, 0.05),
    (6, 'RAM X', 'Especificações: Read: 300 MB/s; Write: 350 MB/s','Armazenamento',100,50,0),
    (7, 'Monitor Asus VS197DE TN', 'Especificações:Tamanho do Ecrã: Wide Screen 18.5" (47.0cm) 16:9; Resolução: 1366x768;Brilho(Máx): 200 cd/㎡:Tamanho do pixel: 0.3mm;Ângulo de Visualização (CR≧10): 90°(H)/65°(V);Tempo de Resposta: 5ms' , 'Imagem', 500, 71.90, 0.24),
    (8, 'Headphones Plantronics BackBeat PRO 2 Wireless SE Cinzento Grafite', 'Especificações:Drivers: Drivers dinâmicos de 40 mm;Conexão: Bluetooth, alcance de até 100 metros;Perfis Bluetooth: Bluetooth® 4.0 + EDR, HSP 1.2, HFP 1.6 (Wideband);Perfis Bluetooth: Bluetooth® 4.0 + EDR, HSP 1.2, HFP 1.6 (Wideband):Cancelamento de ruído: Cancelamento de ruído activo controlável (ANC);Autonomia Bateria: Até: 24 horas, seis meses em DeepSleep;Tipo de Bateria: Recarregável, não substituível íon de lítio', 'Periféricos', 300, 259.90, 0.20);


--
-- Povoamento da tabela "Venda"
INSERT INTO Venda 
    (id, data_venda, preco_total, nif_cliente, id_funcionario, valor_desconto) 
    VALUES 
	(1, '2018-11-25 15:36:28', 0, 748637829, 1,0),
    (2, '2018-11-25 14:02:14', 0, 748637829, 2,0),
    (3, '2017-06-24 20:30:08', 0, 849677721, 2,0),
    (4, '2017-08-30 16:30:08', 0, 815577721, 3,0),
    (5, '2017-08-12 14:50:01', 0, 748637829, 4,0),
    (6, '2017-08-24 19:40:09', 0, 815577721, 4,0),
    (7, '2017-08-29 13:20:18', 0, 214512313, 3,0),
    (8, '2017-09-30 17:06:09', 0, 849677721, 3,0),
    (9, '2017-09-29 20:16:45', 0, 201231323, 5,0),
    (10, '2017-09-03 19:06:05', 0, 214512313, 5,0),
    (11, '2017-09-04 18:06:05', 0, 215343432, 2,0),
    (12, '2017-09-06 19:06:05', 0, 748637829, 3,0),
    (13, '2017-09-09 19:06:05', 0, 201231323, 4,0),
    (14, '2017-10-28 15:06:05', 0, 218765545, 5,0),
    (15, '2017-09-30 20:07:08', 0, 223456343, 1,0),
    (16, '2017-09-29 15:02:01', 0, 219765454, 2,0),
    (17, '2017-11-05 19:06:02', 0, 748637829, 3,0),
    (18, '2017-11-05 13:08:54', 0, 815577721, 4,0),
    (19, '2017-11-06 20:45:35', 0, 219765454, 5,0),
    (20, '2017-11-25 19:34:39', 0, 223456343, 4,0),
    (21, '2017-11-17 19:24:17', 0, 201231323, 4,0),
    (22, '2017-11-19 18:14:22', 0, 218765545, 3,0),
    (23, '2017-11-19 18:14:22', 0, 218765545, 3,0);
 
--
-- Povoamento da tabela "Produto"
INSERT INTO VendaProduto 
    (id_venda, id_produto, quantidade, preco_unitario_final, preco_total, desconto_unitario, desconto_total) 
    VALUES
    (1, 1, 10, 0, 0, 0, 0),
    (1, 2, 5, 0, 0, 0, 0),
    (1, 3, 2, 0, 0, 0, 0),
    (2, 4, 10, 0, 0, 0, 0),
    (2, 5, 5, 0, 0, 0, 0),
    (2, 6, 2, 0, 0, 0, 0),
    (23, 7, 2, 0, 0, 0, 0),
    (23, 8, 2, 0, 0, 0, 0);

--
-- Povoamento da tabela "Servico"
INSERT INTO Servico
	(id, descricao, data_inicio, data_fim, estado_equipamento, id_funcionario, id_venda)
	VALUES
    (1, 'Recuperacao ficheiros apagados', '2017-06-23 10:26:18', NULL, 'Teclado desgastado', 2, 3),
    (2, 'Reparacao motherboard', '2017-08-10 11:26:18', '2017-08-30 15:30:08', 'Logo da marca desgastado', 3, 4),
    (3, 'Reparacao carregador', '2017-08-11 13:26:18', NULL, 'Conservado', 1, 5),
    (4, 'Limpeza de malwares', '2017-08-20 13:16:08', NULL, 'Colunas danificadas', 2, 6),
    (5, 'Bloqueio de publicidade e pop ups', '2017-08-27 18:06:34', '2017-08-29 19:20:18', 'Conservado', 4, 7),
    (6, 'Reparacao chip grafico', '2017-09-28 09:46:02', NULL, 'Luz do logo danificada', 5, 8),
    (7, 'Limpeza interna cooler e chassis', '2017-09-28 19:35:12',NULL, 'Ecra rachado no canto superior direito', 1, 9),
    (8, 'Reparacao rato', '2017-10-02 09:35:10', '2017-09-03 13:06:05', 'Fio cortado', 2, 10),
    (9, 'Reparacao teclado', '2017-10-02 19:35:10', '2017-09-04 15:06:05', 'Nao contem as tecladas r e t', 3, 11),
    (10, 'Recuperacao ficheiros apagados', '2017-10-03 09:35:10', '2017-09-06 13:06:05', 'Logo da marca desgastado', 4, 12),
    (11, 'Limpeza teclado', '2017-10-08 09:35:10', '2017-09-09 14:06:05', 'Conservado', 5, 13),
    (12, 'Formatacao', '2017-10-22 10:35:10', '2017-10-27 18:06:05', 'Ecra rachado', 1, 14),
    (13, 'Atualizacao de software', '2017-09-28 15:35:10', '2017-09-30 19:07:08', 'Conservado', 2, 15),
    (14, 'Instalacao de micro', '2017-09-28 19:34:22', '2017-09-29 10:02:01', 'Luz do logo danificada', 3, 16),
    (15, 'Limpeza teclado', '2017-10-30 16:15:53', NULL, 'Teclas a,w,e,s, e d desgastadas', 2, 17),
    (16, 'Bloqueio de publicidade e pop ups', '2017-11-01 14:27:13', '2017-11-04 17:08:54', 'Conservado', 1, 18),
    (17, 'Limpeza interna cooler e chassis', '2017-11-03 15:39:13', '2017-11-06 18:45:35', 'Logo da marca desgastado', 2, 19),
    (18, 'Reparacao motherboard', '2017-11-08 14:36:25', '2017-11-25 16:34:39', 'Ecra rachado', 2, 20),
    (19, 'Limpeza teclado', '2017-11-09 17:46:38', '2017-11-17 14:24:17', 'Conservado', 1, 21),
    (20, 'Limpeza interna cooler e chassis', '2017-11-13 16:26:31', '2017-11-18 15:14:22', 'Conservado', 4, 22);

DROP PROCEDURE IF EXISTS valida_venda_produto;
DROP PROCEDURE IF EXISTS valida_venda_servico;
DROP PROCEDURE IF EXISTS finaliza_servico;
DROP PROCEDURE IF EXISTS inserir_venda;

-- VALIDA A VENDA DE UM PRODUTO, DADO O ID DA VENDA.
DELIMITER $$
CREATE PROCEDURE valida_venda_produto (IN venda_id INT)
BEGIN

	DECLARE var_valor_total_da_venda DOUBLE;
    DECLARE var_valor_total_decontos DOUBLE;

	DECLARE exit handler for sqlexception
	BEGIN
		SELECT 'ERROR: todo o processo foi anulado! ';
		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
	BEGIN
		SELECT 'WARNING: todo o processo foi anulado!';
		ROLLBACK;
	END;
    
    SET AUTOCOMMIT = 0;

    START TRANSACTION;

    	IF (SELECT Venda.preco_total FROM Venda WHERE Venda.id = venda_id) = 0 THEN
    		
    		UPDATE Produto, VendaProduto 
				SET Produto.stock = Produto.stock - VendaProduto.quantidade
			WHERE VendaProduto.id_venda = venda_id and VendaProduto.id_produto = Produto.id;
            
            UPDATE Produto, VendaProduto -- ATUALIZAMOS O VALOR PREÇO UNITÁRIO FINAL, NA RELAÇÃO VENDAPRODUTO
				SET VendaProduto.preco_unitario_final = Produto.preco_unitario - (Produto.preco_unitario * Produto.desconto)
			WHERE VendaProduto.id_venda = venda_id and VendaProduto.id_produto = Produto.id;
            
             UPDATE Produto, VendaProduto -- ATUALIZAMOS O VALOR DO DESCONTO UNITÁRIO, NA RELAÇÃO VENDAPRODUTO
				SET VendaProduto.desconto_unitario = Produto.preco_unitario - VendaProduto.preco_unitario_final
    		WHERE VendaProduto.id_venda = venda_id and VendaProduto.id_produto = Produto.id;
		
            UPDATE VendaProduto -- ATUALIZAMOS O PREÇO TOTAL, NA RELAÇÃO VENDAPRODUTO
    			SET VendaProduto.preco_total = VendaProduto.preco_unitario_final * VendaProduto.quantidade 
			WHERE VendaProduto.id_venda = venda_id;
		
            UPDATE VendaProduto 	-- ATUALIZAMOS O VALOR TOTAL DO DESCONTO, NA RELAÇÃO VENDAPRODUTO
				SET VendaProduto.desconto_total = VendaProduto.desconto_unitario * VendaProduto.quantidade
			WHERE VendaProduto.id_venda = venda_id;
            
    		SELECT SUM(VendaProduto.preco_total) INTO var_valor_total_da_venda FROM VendaProduto WHERE VendaProduto.id_venda = venda_id;
    		SELECT SUM(VendaProduto.desconto_total) INTO var_valor_total_decontos FROM VendaProduto WHERE VendaProduto.id_venda = venda_id;
            
    		UPDATE Venda, Cliente, Funcionario	-- ATUALIZAÇÃO DOS ATRIBUTOS DERIVADOS DA VENDA, CLIENTE, FUNCIONÁRIO
    			SET Venda.preco_total = var_valor_total_da_venda,
    					Venda.valor_desconto = var_valor_total_decontos,
    					Cliente.valor_total_gasto = Cliente.valor_total_gasto  + var_valor_total_da_venda,
                        Cliente.valor_total_descontos = var_valor_total_decontos,
    					Funcionario.valor_total_vendas = Funcionario.valor_total_vendas + var_valor_total_da_venda
    		WHERE Venda.id = venda_id and Cliente.nif = Venda.nif_cliente and Funcionario.id = Venda.id_funcionario;
    		
    	END IF;
        
    COMMIT;
    
END $$
DELIMITER ;


-- FINALIZA SERVIÇO.
DELIMITER $$
CREATE PROCEDURE finaliza_servico(IN id INT)
BEGIN 
UPDATE Servico
	SET Servico.data_fim = NOW()
		WHERE Servico.id = id;
END $$
DELIMITER $$

-- VALIDA A VENDA DE UM SERVIÇO DADO O ID DA VENDA E O PREÇO DO SERVIÇO.
DELIMITER $$
CREATE PROCEDURE valida_venda_servico(IN venda_id INT, IN preco_servico DOUBLE)
BEGIN

	DECLARE exit handler for sqlexception
	BEGIN
		SELECT 'ERROR: todo o processo foi anulado!';
		ROLLBACK;
	END;

	DECLARE exit handler for sqlwarning
	BEGIN
		SELECT 'WARNING: todo o processo foi anulado!';
		ROLLBACK;
	END;
    
    SET AUTOCOMMIT = 0;
	
    START TRANSACTION;

    -- ATUALIZA A DATA DE FIM DO SERVIÇO, CASO O PROGRAMADOR SE ESQUEÇA DE CHAMAR O PROCEDURE finaliza_servico.
    IF(SELECT Servico.data_fim FROM Servico WHERE Servico.id_venda = venda_id) IS NULL THEN 
		UPDATE Servico, Venda 
			SET Servico.data_fim = Venda.data_venda
				WHERE Servico.id_venda = venda_id and Venda.id = venda_id;
	END IF;
    
    -- ESTE IF GARANTE QUE NÃO SE VALIDA A MESMA VENDA MAIS DO QUE UMA VEZ.
	IF (SELECT Venda.preco_total FROM Venda WHERE Venda.id = venda_id) = 0 THEN 
		UPDATE Venda
			SET Venda.preco_total = preco_servico
				WHERE Venda.id = venda_id;
				
		UPDATE Venda,Cliente
			SET Cliente.valor_total_gasto = Cliente.valor_total_gasto + Venda.preco_total
				WHERE Cliente.nif = Venda.nif_cliente and Venda.id = venda_id;
				
		UPDATE Venda,Funcionario
			SET Funcionario.valor_total_vendas = Funcionario.valor_total_vendas + Venda.preco_total
				WHERE Funcionario.id = Venda.id_funcionario and Venda.id = venda_id;
	END IF;
	COMMIT;
END $$
DELIMITER $$

DELIMITER $$
CREATE PROCEDURE inserir_venda(IN id INT, IN data_venda DATETIME, IN preco_total DOUBLE, IN nif_cliente INT, IN id_funcionario INT, IN valor_desconto DOUBLE)
BEGIN
	INSERT INTO Venda
		VALUES
		(id, data_venda, preco_total, nif_cliente, id_funcionario, valor_desconto);
        
	CALL valida_venda_produto(id);
            
END $$
DELIMITER ;


DROP VIEW IF EXISTS Cliente_Contactos;
DROP VIEW IF EXISTS Funcionario_Contactos;
DROP VIEW IF EXISTS Funcionario_Cliente;
DROP VIEW IF EXISTS Cliente_Morada;
DROP VIEW IF EXISTS Funcionario_Cliente;
DROP VIEW IF EXISTS Funcionario_Cliente;
DROP VIEW IF EXISTS Cliente_Morada;


-- VIEWS:

-- Mostra a informação dos contactos do Cliente
CREATE VIEW Cliente_Contactos AS
	SELECT Cliente.nif, Cliente.nome_completo AS nome, email, ClienteTelefone.nr_telefone FROM Cliente INNER JOIN ClienteTelefone ON Cliente.nif = ClienteTelefone.nif_cliente;

-- Mostra a informação dos contactos do Funcionario.
CREATE VIEW Funcionario_Contactos AS
	SELECT Funcionario.id, Funcionario.nome_completo AS nome, email, FuncionarioTelefone.nr_telefone FROM Funcionario INNER JOIN FuncionarioTelefone ON Funcionario.id = FuncionarioTelefone.id_funcionario;

-- Informação visivel do funcionário sobre o cliente (a informação não evidenciada é apenas para administradores)
-- ou outros departamentos
CREATE VIEW Funcionario_Cliente AS
	SELECT nif, nome_completo as nome, data_nascimento, email, profissao FROM Cliente;


-- Informação apenas da morada do cliente 
CREATE VIEW Cliente_Morada AS
	SELECT nif, nome_completo AS nome, cidade, freguesia, rua, codigo_postal FROM Cliente;


-- USERS:

DROP USER IF EXISTS 'funcionario'@'localhost';

CREATE USER
'funcionario'@'localhost' IDENTIFIED WITH sha256_password BY 'password'
REQUIRE NONE 
WITH MAX_QUERIES_PER_HOUR 5 
MAX_UPDATES_PER_HOUR 5
PASSWORD HISTORY 5;

ALTER USER 'funcionario'@'localhost' WITH MAX_QUERIES_PER_HOUR 10;

GRANT ALL PRIVILEGES ON Cliente TO 'funcionario'@'localhost';
GRANT ALL PRIVILEGES ON BracaTECH.* TO 'funcionario'@'localhost';

REVOKE SELECT ON Cliente FROM 'funcionario'@'localhost';
REVOKE SELECT ON BracaTECH.* FROM 'funcionario'@'localhost';
REVOKE SELECT ON *.* FROM 'funcionario'@'localhost';

-- SHOW GRANTS FOR 'funcionario'@'localhost';
-- SHOW GRANTS FOR 'root'@'localhost';
  
FLUSH PRIVILEGES; 

CALL valida_venda_produto(1);
CALL valida_venda_produto(2);
CALL valida_venda_servico(3, 100);
CALL valida_venda_servico(4, 200);
CALL valida_venda_servico(5, 300);
CALL valida_venda_servico(6, 400);
CALL valida_venda_servico(7, 300);
CALL valida_venda_servico(8, 300);
CALL valida_venda_servico(9, 200);
CALL valida_venda_servico(10, 100);
CALL valida_venda_servico(11, 239);
CALL valida_venda_servico(12, 203);
CALL valida_venda_servico(13, 120);
CALL valida_venda_servico(14, 301);
CALL valida_venda_servico(15, 31);
CALL valida_venda_servico(16, 39);
CALL valida_venda_servico(17, 223);
CALL valida_venda_servico(18, 391);
CALL valida_venda_servico(19, 31);
CALL valida_venda_servico(20, 192);
CALL valida_venda_servico(21, 318);
CALL valida_venda_servico(22, 312);
CALL valida_venda_produto(23);