import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

import java.sql.*;

public class Migracao {

    private Connection con;
    private MongoDatabase db;

    /**
     * Construtor parametrizado.
     * @param con conexão
     * @param db mongo
     */
    public Migracao(Connection con, MongoDatabase db) {
        this.db = db;
        this.con = con;
    }

    /**
     * Migrar os dados dos clientes para a coleção Cliente em MongoDB
     * @throws ClassNotFoundException classe não existe
     */
    public void migrarCliente() throws ClassNotFoundException {
        try {
            int nif, classificacao;
            String nome_completo, sexo,
                    email, profissao;
            Date data_nascimento, data_registo_perfil;
            double valor_total_descontos, valor_total_gasto;

            int nr_telefone;
            String tipo_telefone;

            String codigo_postal, cidade, freguesia, rua;

            this.con = (Connection) Connect.connect();
            String sql = "" + "Select C.nif, C.nome_completo, C.sexo, C.valor_total_descontos, C.valor_total_gasto, C.data_nascimento, C.data_registo_perfil, C.email, C.profissao, C.codigo_postal, C.cidade, C.freguesia, C.rua, C.classificacao FROM Cliente AS C \n";
            PreparedStatement ps = this.con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            MongoCollection<BasicDBObject> collection = this.db.getCollection("Cliente", BasicDBObject.class);

            while(rs.next()){
                nif = rs.getInt("C.nif");
                nome_completo = rs.getString("C.nome_completo");
                sexo = rs.getString("C.sexo");
                valor_total_descontos = rs.getDouble("C.valor_total_descontos");
                valor_total_gasto = rs.getDouble("C.valor_total_gasto");
                data_nascimento = rs.getDate("C.data_nascimento");
                data_registo_perfil = rs.getDate("C.data_registo_perfil");
                email = rs.getString("C.email");
                profissao = rs.getString("C.profissao");
                codigo_postal = rs.getString("C.codigo_postal");
                cidade = rs.getString("C.cidade");
                freguesia = rs.getString("C.freguesia");
                rua = rs.getString("C.rua");
                classificacao = rs.getInt("C.classificacao");   //  classificação é um int

                BasicDBObject document = new BasicDBObject();

                //  ADIÇÃO DAS INFOS INDEPENTES DO CLIENTE

                document.put("nif", nif);
                document.put("nome_completo", nome_completo);
                document.put("sexo", sexo);
                document.put("valor_total_descontos", valor_total_descontos);
                document.put("valor_total_gasto", valor_total_gasto);
                document.put("data_nascimento", data_nascimento);
                document.put("data_registo_perfil", data_registo_perfil);
                document.put("profissao", profissao);
                document.put("classificacao", classificacao);

                //  CONSTRUÇÃO DO DOCUMENTO CONTACTO --------------------------------------------------------------------------------

                BasicDBObject documentoContato = new BasicDBObject();

                documentoContato.put("email", email);   //  adição do email

                PreparedStatement ps2 = this.con.prepareStatement("SELECT CT.nr_telefone, CT.tipo FROM ClienteTelefone AS CT WHERE CT.nif_cliente = ?");

                ps2.setInt(1,nif);

                ResultSet rs2 = ps2.executeQuery();

                BasicDBList listaTelefones = new BasicDBList(); //  lista dos telefones deste cliente

                //  LISTA DE TELEFONES

                while(rs2.next()){
                    nr_telefone = rs2.getInt("CT.nr_telefone");
                    tipo_telefone = rs2.getString("CT.tipo");

                    BasicDBObject documentoTelefone = new BasicDBObject();

                    documentoTelefone.put("nr_telefone", nr_telefone);
                    documentoTelefone.put("tipo", tipo_telefone);

                    listaTelefones.add(documentoTelefone);
                }

                documentoContato.put("Telefones", listaTelefones);  //  adição da lista de telefones ao Documento Contacto

                document.put("Contacto",documentoContato);  //  adição do documento Contacto

                //  ADIÇÃO DO ENDEREÇO --------------------------------------------------------------------------------

                BasicDBObject documentoEndereco = new BasicDBObject();

                documentoEndereco.put("codigo_postal", codigo_postal);
                documentoEndereco.put("cidade",cidade);
                documentoEndereco.put("freguesia",freguesia);
                documentoEndereco.put("rua", rua);

                document.put("Endereco", documentoEndereco);

                collection.insertOne(document); //  adição do documento
            }

            Connect.close(con);

        } catch (SQLException e) {
            e.printStackTrace();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Migrar os dados dos funcionarios para a coleção Funcionario em MongoDB
     * @throws ClassNotFoundException classe não existe
     */
    public void migrarFuncionario() throws ClassNotFoundException{
        try {
            int id;
            String nome_completo, tipo, sexo, email;
            Date data_nascimento, data_registo_perfil;
            double valor_total_vendas, salario;

            int nr_telefone;
            String tipo_telefone;

            String codigo_postal, cidade, freguesia, rua;

            this.con = (Connection) Connect.connect();
            String sql = "" + "Select F.id, F.nome_completo, F.tipo, F.sexo, F.data_nascimento, F.data_registo_perfil, F.valor_total_vendas, F.salario, F.email, F.codigo_postal, F.cidade, F.freguesia, F.rua FROM Funcionario AS F \n";
            PreparedStatement ps = this.con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            MongoCollection<BasicDBObject> collection = this.db.getCollection("Funcionario", BasicDBObject.class);

            while (rs.next()){
                id = rs.getInt("F.id");
                nome_completo = rs.getString("F.nome_completo");
                tipo = rs.getString("F.tipo");
                sexo = rs.getString("F.sexo");
                data_nascimento = rs.getDate("F.data_nascimento");
                data_registo_perfil = rs.getDate("F.data_registo_perfil");
                valor_total_vendas = rs.getDouble("F.valor_total_vendas");
                salario = rs.getDouble("F.salario");
                email = rs.getString("F.email");    //  email vai ser adicionado lá embaixo no Contacto
                codigo_postal = rs.getString("F.codigo_postal");    //  o mesmo para o endereço
                cidade = rs.getString("F.cidade");
                freguesia = rs.getString("F.freguesia");
                rua = rs.getString("F.rua");

                BasicDBObject document = new BasicDBObject();

                document.put("id", id);
                document.put("nome_completo", nome_completo);
                document.put("tipo", tipo);
                document.put("sexo", sexo);
                document.put("data_nascimento", data_nascimento);
                document.put("data_registo_perfil", data_registo_perfil);
                document.put("valor_total_vendas", valor_total_vendas);
                document.put("salario", salario);

                //  ADIÇÃO DE CONTACTO --------------------------------------------------------------------------------

                BasicDBObject documentoContato = new BasicDBObject();

                documentoContato.put("email", email);

                PreparedStatement ps2 = this.con.prepareStatement(""+"SELECT FP.nr_telefone, FP.tipo FROM FuncionarioTelefone AS FP WHERE FP.id_funcionario = ?");

                ps2.setInt(1,id);   //  atribui o id ao ponto de ?

                ResultSet rs2 = ps2.executeQuery();

                BasicDBList listaTelefones = new BasicDBList();

                //  ADIÇÃO DOS TELEFONES AO DOCUMENTO CONTACTO

                while(rs2.next()){
                    nr_telefone = rs2.getInt("FP.nr_telefone");
                    tipo_telefone = rs2.getString("FP.tipo");

                    BasicDBObject documentoTelefone = new BasicDBObject();

                    documentoTelefone.put("nr_telefone", nr_telefone);
                    documentoTelefone.put("tipo", tipo_telefone);

                    listaTelefones.add(documentoTelefone);
                }

                documentoContato.put("Telefones", listaTelefones);  //  adição da lista de telefones ao Documento Contacto

                document.put("Contacto",documentoContato);  //  adição do documento Contacto

                //  ADIÇÃO DO ENDEREÇO --------------------------------------------------------------------------------

                BasicDBObject documentoEndereco = new BasicDBObject();

                documentoEndereco.put("codigo_postal", codigo_postal);
                documentoEndereco.put("cidade",cidade);
                documentoEndereco.put("freguesia",freguesia);
                documentoEndereco.put("rua", rua);

                document.put("Endereco", documentoEndereco);

                collection.insertOne(document); //  inserção na coleção
            }

            Connect.close(con);

        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Migrar os dados dos Produto para a coleção Produto em MongoDB
     * @throws ClassNotFoundException classe não existe
     */
    public void migrarProduto() throws ClassNotFoundException{
        try {
            int id, stock;
            String designacao, descricao, categoria;
            float preco_unitario, desconto;

            this.con = (Connection) Connect.connect();
            String sql = "" + "Select P.id, P.designacao, P.descricao, P.categoria, P.stock, P.preco_unitario, P.desconto FROM Produto AS P \n";
            PreparedStatement ps = this.con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            MongoCollection<BasicDBObject> collection = this.db.getCollection("Produto", BasicDBObject.class);

            while(rs.next()){
                id = rs.getInt("P.id");
                designacao = rs.getString("P.designacao");
                descricao = rs.getString("P.descricao");
                categoria = rs.getString("P.categoria");
                stock = rs.getInt("P.stock");
                preco_unitario = rs.getFloat("P.preco_unitario");
                desconto = rs.getFloat("P.desconto");

                BasicDBObject document = new BasicDBObject();

                document.put("id", id);
                document.put("designacao",designacao);
                document.put("descricao", descricao);
                document.put("categoria", categoria);
                document.put("stock", stock);
                document.put("preco_unitario", preco_unitario);
                document.put("desconto", desconto);

                collection.insertOne(document);
            }

            Connect.close(con);
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Migrar os dados dos Serviços para a coleção Servico em MongoDB
     * @throws ClassNotFoundException classe não existe
     */
    public void migrarServico() throws ClassNotFoundException{
        try{
            int id, id_venda ,id_funcionario;
            String descricao, estado_equipamento;
            Date data_inicio, data_fim;

            this.con = (Connection) Connect.connect();
            String sql = "" + "Select S.id, S.descricao, S.data_inicio, S.data_fim, S.estado_equipamento, S.id_funcionario, S.id_venda FROM Servico AS S \n";
            PreparedStatement ps = this.con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            MongoCollection<BasicDBObject> collection = this.db.getCollection("Servico", BasicDBObject.class);

            while(rs.next()){
                id = rs.getInt("S.id");
                descricao = rs.getString("S.descricao");
                data_inicio = rs.getDate("S.data_inicio");
                data_fim = rs.getDate("S.data_fim");
                estado_equipamento = rs.getString("S.estado_equipamento");
                id_funcionario = rs.getInt("S.id_funcionario");
                id_venda = rs.getInt("S.id_venda");

                BasicDBObject document = new BasicDBObject();

                document.put("id", id);
                document.put("descricao", descricao);
                document.put("data_inicio", data_inicio);
                document.put("data_fim", data_fim);
                document.put("estado_equipamento", estado_equipamento);
                document.put("id_funcionario", id_funcionario);
                document.put("id_venda", id_venda);

                collection.insertOne(document);
            }

            Connect.close(con);

        }catch(SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * Migrar os dados dos Venda para a coleção Venda em MongoDB
     * @throws ClassNotFoundException classe não existe
     */
    public void migrarVenda() throws ClassNotFoundException{
        try{
            int id;
            Date data;
            double preco_total, desconto_total;

            int nif_cliente;
            String nome_completo_cliente;

            int id_funcionario;
            String nome_completo_funcionario;

            int id_produto, quantidade_produto;
            double preco_unitario_final_produto, preco_total_produto, desconto_unitario_produto,desconto_total_produto;
            String designacao_produto;

            int id_servico;
            Date data_inicio, data_fim;

            this.con = (Connection) Connect.connect();
            String sql = "" + "Select V.id, V.data_venda, V.preco_total, V.valor_desconto FROM Venda AS V \n";
            PreparedStatement ps = this.con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            MongoCollection<BasicDBObject> collection = this.db.getCollection("Venda", BasicDBObject.class);

            while(rs.next()){
                id = rs.getInt("V.id");
                data = rs.getDate("V.data_venda");
                preco_total = rs.getDouble("V.preco_total");
                desconto_total = rs.getDouble("V.valor_desconto");

                BasicDBObject document = new BasicDBObject();

                document.put("id", id);
                document.put("data", data);
                document.put("preco_total", preco_total);
                document.put("desconto_total", desconto_total);

                //  ADIÇÃO DO CLIENTE À VENDA!!!! ----------------------------------------------------------------------

                PreparedStatement ps2 = this.con.prepareStatement("SELECT C.nif, C.nome_completo FROM Venda AS V INNER JOIN Cliente AS C ON C.nif = V.nif_cliente WHERE V.id = ?");

                ps2.setInt(1, id);

                ResultSet rs2 = ps2.executeQuery();

                while (rs2.next()){
                    nif_cliente = rs2.getInt("C.nif");
                    nome_completo_cliente = rs2.getString("C.nome_completo");

                    BasicDBObject documentoCliente = new BasicDBObject();

                    documentoCliente.put("nif",nif_cliente);
                    documentoCliente.put("nome_completo", nome_completo_cliente);

                    document.put("Cliente", documentoCliente);  //  adição do cliente à venda
                }

                //  ADIÇÃO DO FUNCIONÁRIO À VENDA!!!! -----------------------------------------------------------------

                PreparedStatement ps3 = this.con.prepareStatement(""+"SELECT F.id, F.nome_completo FROM Venda AS V INNER JOIN Funcionario AS F ON F.id = V.id_funcionario WHERE V.id = ?");
                ps3.setInt(1,id);

                ResultSet rs3 = ps3.executeQuery();

                while (rs3.next()){
                    id_funcionario = rs3.getInt("F.id");
                    nome_completo_funcionario = rs3.getString("F.nome_completo");

                    BasicDBObject documentoFuncionario = new BasicDBObject();

                    documentoFuncionario.put("id_funcionario", id_funcionario);
                    documentoFuncionario.put("nome_funcionario", nome_completo_funcionario);

                    document.put("Funcionario", documentoFuncionario);
                }

                //  ADIÇÃO DOS PRODUTOS À VENDA !!!! ------------------------------------------------------------------

                PreparedStatement ps4  = this.con.prepareStatement(""+"SELECT P.id, P.designacao, VP.quantidade, VP.preco_unitario_final, VP.preco_total, VP.desconto_unitario, VP.desconto_total FROM Produto AS P INNER JOIN VendaProduto AS VP ON P.id = VP.id_produto INNER JOIN Venda AS V ON VP.id_venda = V.id WHERE V.id = ?");
                ps4.setInt(1,id);

                ResultSet rs4 = ps4.executeQuery();

                BasicDBList lista_produtos = new BasicDBList();

                int flag = 0;

                while(rs4.next()){
                    flag++; //  para garantir que não adiciona produtos caso não haja;
                    id_produto = rs4.getInt("P.id");
                    designacao_produto = rs4.getString("P.designacao");
                    quantidade_produto = rs4.getInt("VP.quantidade");
                    preco_unitario_final_produto = rs4.getFloat("VP.preco_unitario_final");
                    preco_total_produto = rs4.getFloat("VP.preco_total");
                    desconto_unitario_produto = rs4.getFloat("VP.desconto_unitario");
                    desconto_total_produto = rs4.getFloat("VP.desconto_total");

                    BasicDBObject documento_produto = new BasicDBObject();

                    documento_produto.put("id_produto", id_produto);
                    documento_produto.put("designacao", designacao_produto);
                    documento_produto.put("quantidade", quantidade_produto);
                    documento_produto.put("preco_unitario_final", preco_unitario_final_produto);
                    documento_produto.put("preco_total", preco_total_produto);
                    documento_produto.put("desconto_unitario", desconto_unitario_produto);
                    documento_produto.put("desconto_total", desconto_total_produto);

                    lista_produtos.add(documento_produto);  //  lista dos produtos
                }

                if(flag > 0)document.put("Produtos", lista_produtos);   //  adição dos produtos


                //  ADIÇÃO DOS SERVIÇOS À VENDA !!!! ------------------------------------------------------------------

                PreparedStatement ps5  = this.con.prepareStatement("SELECT S.id, S.data_inicio, S.data_fim FROM Servico AS S INNER JOIN Venda AS V ON S.id_venda = V.id WHERE V.id = ?");

                ps5.setInt(1,id);

                ResultSet rs5 = ps5.executeQuery();

                while(rs5.next()){
                    id_servico = rs5.getInt("S.id");
                    data_inicio = rs5.getDate("S.data_inicio");
                    data_fim = rs5.getDate("S.data_fim");

                    BasicDBObject documentoServico = new BasicDBObject();

                    documentoServico.put("id_servico", id_servico);
                    documentoServico.put("data_inicio", data_inicio);
                    documentoServico.put("data_fim",data_fim);

                    document.put("Servico",documentoServico);
                }

                collection.insertOne(document);
            }
            Connect.close(con);
        }catch (SQLException e){
            e.printStackTrace();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    /**
     * Faz drop dos dados que está no mongo
     */
    public void drop ()
    {
        MongoCollection<BasicDBObject> collection = this.db.getCollection("Cliente",BasicDBObject.class);
        collection.drop();
        collection = this.db.getCollection("Funcionario", BasicDBObject.class);
        collection.drop();
        collection = this.db.getCollection("Produto", BasicDBObject.class);
        collection.drop();
        collection = this.db.getCollection("Servico", BasicDBObject.class);
        collection.drop();
        collection = this.db.getCollection("Venda", BasicDBObject.class);
        collection.drop();
    }
}
