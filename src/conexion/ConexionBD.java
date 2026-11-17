package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static final String URL = "jdbc:mysql://localhost:3306/db_ultraphone70?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String CLAVE = "ADMIN"; // Escribe tu contraseña de MySQL si tienes una

    public static Connection obtenerConexion() {
        Connection conexion = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USUARIO, CLAVE);
            System.out.println("¡Conexión exitosa a la base de datos de UltraPhone70!");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error al conectar a la BD: " + e.getMessage());
        }
        return conexion;
    }
}