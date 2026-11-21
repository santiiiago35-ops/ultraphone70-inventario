
package modelo;

public class Producto {

    private int idCelular;
    private String marca;
    private String modelo;
    private String imei;
    private double precioCompra;
    private double precioVenta;
    private int stock;
    private int idProveedor;

    // Constructor vacío
    public Producto() {
    }

    // Constructor con parámetros
    public Producto(String marca, String modelo, String imei,
                    double precioCompra, double precioVenta,
                    int stock, int idProveedor) {

        this.marca = marca;
        this.modelo = modelo;
        this.imei = imei;
        this.precioCompra = precioCompra;
        this.precioVenta = precioVenta;
        this.stock = stock;
        this.idProveedor = idProveedor;
    }

    public int getIdCelular() {
        return idCelular;
    }

    public void setIdCelular(int idCelular) {
        this.idCelular = idCelular;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei;
    }

    public double getPrecioCompra() {
        return precioCompra;
    }

    public void setPrecioCompra(double precioCompra) {
        this.precioCompra = precioCompra;
    }

    public double getPrecioVenta() {
        return precioVenta;
    }

    public void setPrecioVenta(double precioVenta) {
        this.precioVenta = precioVenta;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getIdProveedor() {
        return idProveedor;
    }

    public void setIdProveedor(int idProveedor) {
        this.idProveedor = idProveedor;
    }
}
