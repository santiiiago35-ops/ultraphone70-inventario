package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {

    private static final String URL =
        "jdbc:mysql://localhost:3306/inventario_celulares?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";

    private static final String USUARIO = System.getenv("DB_USER");
    private static final String CLAVE = System.getenv("DB_PASSWORD");

    public static Connection obtenerConexion() {

        try {
            if (USUARIO == null || CLAVE == null) {
                System.err.println(
                    "Faltan las variables de entorno DB_USER o DB_PASSWORD."
                );
                return null;
            }

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conexion = DriverManager.getConnection(
                URL, USUARIO, CLAVE
            );

            System.out.println(
                "¡Conexión exitosa a la base de datos de UltraPhone70!"
            );

            return conexion;

        } catch (ClassNotFoundException | SQLException e) {
            System.err.println(
                "Error al conectar con MySQL: " + e.getMessage()
            );
            return null;
        }
    }
}
