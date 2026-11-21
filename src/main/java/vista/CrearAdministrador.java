package vista;

import conexion.ConexionBD;
import org.mindrot.jbcrypt.BCrypt;

import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CrearAdministrador {

    public static void main(String[] args) {

        String nombre = JOptionPane.showInputDialog(
                null, "Nombre del administrador:");

        if (nombre == null || nombre.isBlank()) {
            return;
        }

        String correo = JOptionPane.showInputDialog(
                null, "Correo del administrador:");

        if (correo == null || correo.isBlank()) {
            return;
        }

        JPasswordField campoClave = new JPasswordField();

        int opcion = JOptionPane.showConfirmDialog(
                null,
                campoClave,
                "Escribe la contraseña del administrador",
                JOptionPane.OK_CANCEL_OPTION
        );

        if (opcion != JOptionPane.OK_OPTION) {
            return;
        }

        String clave = new String(campoClave.getPassword());

        if (clave.length() < 8) {
            JOptionPane.showMessageDialog(
                    null,
                    "La contraseña debe tener al menos 8 caracteres."
            );
            return;
        }

        String sql = """
            INSERT INTO usuario
            (nombre, correo, contraseña, telefono, estado, id_rol)
            VALUES (?, ?, ?, ?, 1, 1)
        """;

        try (Connection conexion = ConexionBD.obtenerConexion()) {

            if (conexion == null) {
                JOptionPane.showMessageDialog(
                        null, "No se pudo conectar con MySQL.");
                return;
            }

            String consultaCorreo =
                    "SELECT id_usuario FROM usuario WHERE correo = ?";

            try (PreparedStatement verificar =
                         conexion.prepareStatement(consultaCorreo)) {

                verificar.setString(1, correo.trim());

                try (ResultSet resultado = verificar.executeQuery()) {
                    if (resultado.next()) {
                        JOptionPane.showMessageDialog(
                                null, "Ese correo ya está registrado.");
                        return;
                    }
                }
            }

            String hash = BCrypt.hashpw(
                    clave, BCrypt.gensalt(12));

            try (PreparedStatement insertar =
                         conexion.prepareStatement(sql)) {

                insertar.setString(1, nombre.trim());
                insertar.setString(2, correo.trim());
                insertar.setString(3, hash);
                insertar.setString(4, "");

                insertar.executeUpdate();

                JOptionPane.showMessageDialog(
                        null,
                        "Administrador creado correctamente."
                );
            }

        } catch (Exception e) {
            JOptionPane.showMessageDialog(
                    null,
                    "Error al crear administrador: " + e.getMessage()
            );
        }
    }
}
