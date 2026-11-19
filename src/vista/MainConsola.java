package vista;

import dao.ProductoDAO;

public class MainConsola {
    public static void main(String[] args) {
        ProductoDAO productoDao = new ProductoDAO();

        // 1. Probar registro (Create)
        productoDao.registrarProducto("Samsung", "Galaxy A55", "356789012345699", 1250000, 1550000, 3, 8);

        // 2. Probar consulta (Read)
        productoDao.consultarInventario();

        // 3. Probar actualización (Update)
        productoDao.actualizarStockProducto("356789012345699", 12);

        // 4. Probar eliminación (Delete)
        productoDao.eliminarProducto("356789012345699");
    }
}