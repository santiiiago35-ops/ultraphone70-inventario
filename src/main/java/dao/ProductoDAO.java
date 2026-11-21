package dao;

import conexion.ConexionBD;
import modelo.Producto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    // 1. REGISTRAR PRODUCTO
    public boolean registrarProducto(String marca, String modelo,
            String imei, double precioCompra, double precioVenta,
            int stock, int idProveedor) {

        String sql = "INSERT INTO producto_celular "
                + "(marca, modelo, imei, precio_compra, precio_venta, stock, id_proveedor) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionBD.obtenerConexion()) {

            if (con == null) return false;

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, marca);
                ps.setString(2, modelo);
                ps.setString(3, imei);
                ps.setDouble(4, precioCompra);
                ps.setDouble(5, precioVenta);
                ps.setInt(6, stock);
                ps.setInt(7, idProveedor);

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error al registrar producto: " + e.getMessage());
        }

        return false;
    }

    // 2. CONSULTAR INVENTARIO PARA LA CONSOLA
    public void consultarInventario() {

        String sql = "SELECT id_celular, marca, modelo, imei, "
                + "precio_compra, precio_venta, stock, id_proveedor "
                + "FROM producto_celular";

        try (Connection con = ConexionBD.obtenerConexion()) {

            if (con == null) return;

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                System.out.println("\n--- INVENTARIO ULTRAPHONE70 ---");

                while (rs.next()) {
                    System.out.println(
                            "ID: " + rs.getInt("id_celular")
                            + " | Marca: " + rs.getString("marca")
                            + " | Modelo: " + rs.getString("modelo")
                            + " | IMEI: " + rs.getString("imei")
                            + " | Precio compra: " + rs.getBigDecimal("precio_compra")
                            + " | Precio venta: " + rs.getBigDecimal("precio_venta")
                            + " | Stock: " + rs.getInt("stock")
                            + " | Proveedor: " + rs.getInt("id_proveedor")
                    );
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al consultar inventario: " + e.getMessage());
        }
    }

    // 3. CONSULTAR INVENTARIO PARA LA PAGINA WEB
    public List<Producto> listarProductos() {

        List<Producto> productos = new ArrayList<>();

        String sql = "SELECT id_celular, marca, modelo, imei, "
                + "precio_compra, precio_venta, stock, id_proveedor "
                + "FROM producto_celular ORDER BY id_celular";

        try (Connection con = ConexionBD.obtenerConexion()) {

            if (con == null) return productos;

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Producto producto = new Producto();

                    producto.setIdCelular(rs.getInt("id_celular"));
                    producto.setMarca(rs.getString("marca"));
                    producto.setModelo(rs.getString("modelo"));
                    producto.setImei(rs.getString("imei"));
                    producto.setPrecioCompra(rs.getDouble("precio_compra"));
                    producto.setPrecioVenta(rs.getDouble("precio_venta"));
                    producto.setStock(rs.getInt("stock"));
                    producto.setIdProveedor(rs.getInt("id_proveedor"));

                    productos.add(producto);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error al listar productos: " + e.getMessage());
        }

        return productos;
    }

    // 4. ACTUALIZAR STOCK POR IMEI
    public boolean actualizarStockProducto(String imei, int nuevoStock) {

        String sql = "UPDATE producto_celular SET stock = ? WHERE imei = ?";

        try (Connection con = ConexionBD.obtenerConexion()) {

            if (con == null) return false;

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, nuevoStock);
                ps.setString(2, imei);

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error al actualizar stock: " + e.getMessage());
        }

        return false;
    }

    // 5. ELIMINAR PRODUCTO POR IMEI
    public boolean eliminarProducto(String imei) {

        String sql = "DELETE FROM producto_celular WHERE imei = ?";

        try (Connection con = ConexionBD.obtenerConexion()) {

            if (con == null) return false;

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, imei);

                return ps.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error al eliminar producto: " + e.getMessage());
        }

        return false;
    }
}
