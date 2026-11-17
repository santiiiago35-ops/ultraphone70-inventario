package dao;

import conexion.ConexionBD;
import java.sql.*;

public class ProductoDAO {

    // 1. CREAR (Insertar un nuevo producto)
    public boolean registrarProducto(String marca, String modelo, String imei, double precioCompra, double precioVenta, int stockMinimo, int stockActual) {
        String sql = "INSERT INTO producto (marca, modelo, imei, precio_compra, precio_venta, stock_minimo, stock_actual) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, marca);
            ps.setString(2, modelo);
            ps.setString(3, imei);
            ps.setDouble(4, precioCompra);
            ps.setDouble(5, precioVenta);
            ps.setInt(6, stockMinimo);
            ps.setInt(7, stockActual);
            ps.executeUpdate();
            System.out.println("-> Producto registrado exitosamente en el inventario.");
            return true;
        } catch (SQLException e) {
            System.err.println("Error al registrar producto: " + e.getMessage());
            return false;
        }
    }

    // 2. CONSULTAR (Listar productos del inventario)
    public void consultarInventario() {
        String sql = "SELECT * FROM producto";
        try (Connection con = ConexionBD.obtenerConexion();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            System.out.println("\n--- INVENTARIO ACTUAL ULTRAPHONE70 ---");
            while (rs.next()) {
                System.out.println("ID: " + rs.getInt("id_celular") + 
                                   " | Marca: " + rs.getString("marca") + 
                                   " | Modelo: " + rs.getString("modelo") + 
                                   " | IMEI: " + rs.getString("imei") + 
                                   " | Stock: " + rs.getInt("stock_actual"));
            }
        } catch (SQLException e) {
            System.err.println("Error al consultar el inventario: " + e.getMessage());
        }
    }

    // 3. ACTUALIZAR (Modificar stock por IMEI)
    public boolean actualizarStockProducto(String imei, int nuevoStock) {
        String sql = "UPDATE producto SET stock_actual = ? WHERE imei = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, nuevoStock);
            ps.setString(2, imei);
            ps.executeUpdate();
            System.out.println("-> Stock actualizado correctamente.");
            return true;
        } catch (SQLException e) {
            System.err.println("Error al actualizar stock: " + e.getMessage());
            return false;
        }
    }

    // 4. ELIMINAR (Borrar producto por IMEI)
    public boolean eliminarProducto(String imei) {
        String sql = "DELETE FROM producto WHERE imei = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, imei);
            int filasAfectadas = ps.executeUpdate();
            if (filasAfectadas > 0) {
                System.out.println("-> Producto eliminado del sistema.");
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error al eliminar: " + e.getMessage());
        }
        return false;
    }
}

