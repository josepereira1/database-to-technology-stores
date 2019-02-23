DESC Cliente;
DESC ClienteTelefone;
DESC Funcionario;
DESC FuncionarioTelefone;
DESC Produto;
DESC Servico;
DESC Venda;
DESC VendaProduto;

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
--
SELECT * FROM Funcionario;
SELECT * FROM Cliente;
SELECT * FROM Venda;
SELECT * FROM VendaProduto;
SELECT * FROM Produto;
