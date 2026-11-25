package dao;

import conexion.ConexionBD;
import modelo.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {

    public Usuario autenticar(String correo, String clave) {

        String sql = "SELECT id_usuario, nombre, contrasena FROM usuario WHERE nombre = ?";

        System.out.println("[DEBUG] Autenticando correo: [" + correo + "]");

        try (Connection conexion = ConexionBD.obtenerConexion()) {

            if (conexion == null) {
                System.err.println("[DEBUG] No hay conexión con MySQL.");
                return null;
            }

            try (var meta = conexion.prepareStatement("SELECT DATABASE(), @@hostname, @@port").executeQuery()) {
                if (meta.next()) {
                    System.out.println("[DEBUG] BD activa: " + meta.getString(1)
                            + " | Host: " + meta.getString(2)
                            + " | Puerto: " + meta.getString(3));
                }
            }

            try (PreparedStatement consulta = conexion.prepareStatement(sql)) {

                consulta.setString(1, correo);

                try (ResultSet resultado = consulta.executeQuery()) {

                    if (!resultado.next()) {
                        System.out.println("[DEBUG] No se encontró ningún usuario con nombre: [" + correo + "]");
                        return null;
                    }

                    String claveGuardada = resultado.getString("contrasena");
                    String claveLimpia = clave != null ? clave.trim() : null;
                    String guardadaLimpia = claveGuardada != null ? claveGuardada.trim() : null;

                    System.out.println("[DEBUG] Clave recibida: [" + clave + "] | Clave en BD: [" + claveGuardada + "]");

                    if (guardadaLimpia != null && guardadaLimpia.equals(claveLimpia)) {

                        Usuario usuario = new Usuario();
                        usuario.setIdUsuario(resultado.getInt("id_usuario"));
                        usuario.setNombre(resultado.getString("nombre"));
                        usuario.setCorreo(resultado.getString("nombre"));
                        usuario.setNombreRol("Administrador");
                        usuario.setEstado(1);

                        System.out.println("[DEBUG] Autenticación exitosa para: " + usuario.getNombre());
                        return usuario;
                    } else {
                        System.out.println("[DEBUG] La clave en BD no coincide con la ingresada.");
                    }
                }
            }

        } catch (Exception e) {
            System.err.println("Error al autenticar usuario: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }
}