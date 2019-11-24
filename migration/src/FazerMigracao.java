import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;

import java.sql.Connection;

public class FazerMigracao {

    public static void main(String[] args) throws ClassNotFoundException {
            MongoClient mongo = new MongoClient("localhost",27017);
            MongoDatabase db = mongo.getDatabase("project");

            Connection con = null;

            Migracao m = new Migracao(con, db);

            m.drop();
            m.migrarCliente();
            m.migrarFuncionario();
            m.migrarProduto();
            m.migrarServico();
            m.migrarVenda();
    }
}
