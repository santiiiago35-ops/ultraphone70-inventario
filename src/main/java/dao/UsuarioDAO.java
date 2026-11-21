package dao;

import conexion.ConexionBD;
import modelo.Usuario;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {

    public Usuario autenticar(String correo, String clave) {

        String sql = """
            SELECT u.id_usuario,
                   u.nombre,
                   u.correo,
                   u.contraseña,
                   u.estado,
                   u.id_rol,
                   r.nombre_rol
            FROM usuario u
            INNER JOIN rol r ON u.id_rol = r.id_rol
            WHERE u.correo = ?
            AND u.estado = 1
        """;

        try (Connection conexion = ConexionBD.obtenerConexion()) {

            if (conexion == null) {
                System.err.println("No hay conexión con MySQL.");
                return null;
            }

            try (PreparedStatement consulta = conexion.prepareStatement(sql)) {

                consulta.setString(1, correo);

                try (ResultSet resultado = consulta.executeQuery()) {

                    if (resultado.next()) {

                        String hashGuardado =
                                resultado.getString("contraseña");

                        if (BCrypt.checkpw(clave, hashGuardado)) {

                            Usuario usuario = new Usuario();

                            usuario.setIdUsuario(
                                    resultado.getInt("id_usuario"));

                            usuario.setNombre(
                                    resultado.getString("nombre"));

                            usuario.setCorreo(
                                    resultado.getString("correo"));

                            usuario.setEstado(
                                    resultado.getInt("estado"));

                            usuario.setIdRol(
                                    resultado.getInt("id_rol"));

                            usuario.setNombreRol(
                                    resultado.getString("nombre_rol"));

                            return usuario;
                        }
                    }
                }
            }

        } catch (Exception e) {
            System.err.println(
                    "Error al autenticar usuario: " + e.getMessage());
        }

        return null;
    }
}
