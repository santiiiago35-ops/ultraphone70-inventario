package modelo;

public class Producto {
    private int idCelular;
    private String marca;
    private String modelo;
    private String imei;
    private double precioCompra;
    private double precioVenta;
    private int stockMinimo;
    private int stockActual;

    // Constructor vacío
    public Producto() {
    }

    // Constructor con parámetros
    public Producto(String marca, String modelo, String imei, double precioCompra, double precioVenta, int stockMinimo, int stockActual) {
        this.marca = marca;
        this.modelo = modelo;
        this.imei = imei;
        this.precioCompra = precioCompra;
        this.precioVenta = precioVenta;
        this.stockMinimo = stockMinimo;
        this.stockActual = stockActual;
    }

    // Getters y Setters (Métodos para obtener y modificar los valores)
    public int getIdCelular() { return idCelular; }
    public void setIdCelular(int idCelular) { this.idCelular = idCelular; }

    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }

    public String getModelo() { return modelo; }
    public void setModelo(String modelo) { this.modelo = modelo; }

    public String getImei() { return imei; }
    public void setImei(String imei) { this.imei = imei; }

    public double getPrecioCompra() { return precioCompra; }
    public void setPrecioCompra(double precioCompra) { this.precioCompra = precioCompra; }

    public double getPrecioVenta() { return precioVenta; }
    public void setPrecioVenta(double precioVenta) { this.precioVenta = precioVenta; }

    public int getStockMinimo() { return stockMinimo; }
    public void setStockMinimo(int stockMinimo) { this.stockMinimo = stockMinimo; }

    public int getStockActual() { return stockActual; }
    public void setStockActual(int stockActual) { this.stockActual = stockActual; }
}