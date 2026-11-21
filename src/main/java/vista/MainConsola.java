
package vista;

import dao.ProductoDAO;

public class MainConsola {

    public static void main(String[] args) {

        ProductoDAO productoDao = new ProductoDAO();

        // Datos de prueba
        String imeiPrueba = "356789012345699";

        // IMPORTANTE: utiliza un ID de proveedor que exista
        // en la tabla proveedor.
        int idProveedor = 1;

        System.out.println("================================");
        System.out.println(" SISTEMA DE INVENTARIO ULTRAPHONE70");
        System.out.println("================================");

        // 1. REGISTRAR PRODUCTO
        System.out.println("\n1. REGISTRAR PRODUCTO");

        boolean registrado = productoDao.registrarProducto(
                "Samsung",
                "Galaxy A55",
                imeiPrueba,
                1250000,
                1550000,
                8,
                idProveedor
        );

        // 2. CONSULTAR INVENTARIO
        System.out.println("\n2. CONSULTAR INVENTARIO");
        productoDao.consultarInventario();

        // 3. ACTUALIZAR STOCK
        System.out.println("\n3. ACTUALIZAR STOCK");

        if (registrado) {
            productoDao.actualizarStockProducto(imeiPrueba, 12);
        }

        // 4. CONSULTAR NUEVAMENTE
        System.out.println("\n4. VERIFICAR ACTUALIZACION");
        productoDao.consultarInventario();

        // No eliminamos el registro automáticamente.
        // Así podemos comprobarlo en MySQL Workbench.

        System.out.println("\n================================");
        System.out.println(" PRUEBA FINALIZADA");
        System.out.println("================================");
    }
}
