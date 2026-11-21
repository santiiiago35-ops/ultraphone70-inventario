package vista;

import conexion.ConexionBD;
import java.sql.Connection;

public class PruebaConexion {

    public static void main(String[] args) {

        try (Connection conexion = ConexionBD.obtenerConexion()) {

            if (conexion != null) {
                System.out.println("CONEXION EXITOSA CON MYSQL");
            } else {
                System.out.println("NO SE PUDO CONECTAR CON MYSQL");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}