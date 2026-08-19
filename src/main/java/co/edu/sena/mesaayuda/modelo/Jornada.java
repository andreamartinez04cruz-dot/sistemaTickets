package co.edu.sena.mesaayuda.modelo;

public class Jornada {

    private int id;
    private TipoJornada tipo;

    public Jornada() {
    }

    public Jornada(int id, TipoJornada tipo) {
        this.id = id;
        this.tipo = tipo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public TipoJornada getTipo() {
        return tipo;
    }

    public void setTipo(TipoJornada tipo) {
        this.tipo = tipo;
    }
}
