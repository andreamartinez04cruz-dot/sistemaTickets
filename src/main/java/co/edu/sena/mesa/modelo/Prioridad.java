package co.edu.sena.mesa.modelo;

public class Prioridad {

    private int id;
    private String nombre;

    public Prioridad() {
    }

    public Prioridad(int id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
