package modelo;

public class Usuario {

    private int idUsuario;
    private String nombre;
    private String correo;
    private int estado;
    private int idRol;
    private String nombreRol;

    public Usuario() {
    }

    public Usuario(int idUsuario, String nombre, String correo,
                   int estado, int idRol, String nombreRol) {

        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.correo = correo;
        this.estado = estado;
        this.idRol = idRol;
        this.nombreRol = nombreRol;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public int getIdRol() {
        return idRol;
    }

    public void setIdRol(int idRol) {
        this.idRol = idRol;
    }

    public String getNombreRol() {
        return nombreRol;
    }

    public void setNombreRol(String nombreRol) {
        this.nombreRol = nombreRol;
    }
}
