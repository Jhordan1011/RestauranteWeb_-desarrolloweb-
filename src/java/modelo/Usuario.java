/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

public class Usuario {
    private int id; // nuevo atributo
    private String nombreCompleto;
    private String correo;
    private String telefono;
    private String direccion;
    private String contrasena;

    // Constructor con id (para cargar usuarios desde BD)
    public Usuario(int id, String nombreCompleto, String correo, String telefono, String direccion, String contrasena) {
        this.id = id;
        this.nombreCompleto = nombreCompleto;
        this.correo = correo;
        this.telefono = telefono;
        this.direccion = direccion;
        this.contrasena = contrasena;
    }

    // Constructor sin id (para crear nuevo usuario antes de insertarlo en BD)
    public Usuario(String nombreCompleto, String correo, String telefono, String direccion, String contrasena) {
        this.nombreCompleto = nombreCompleto;
        this.correo = correo;
        this.telefono = telefono;
        this.direccion = direccion;
        this.contrasena = contrasena;
    }

    // Getter y setter para id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getters para los demás atributos
    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public String getCorreo() {
        return correo;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getContrasena() {
        return contrasena;
    }
}

