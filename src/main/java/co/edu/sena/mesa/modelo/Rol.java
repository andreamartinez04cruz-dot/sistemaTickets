package co.edu.sena.mesa.modelo;

public class Rol {
    private int id;
    private String tiporol;

    public Rol(int id, String tiporol) {
        this.id = id;
        this.tiporol = tiporol;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTiporol() {
        return tiporol;
    }

    public void setTiporol(String tiporol) {
        this.tiporol = tiporol;
    }
    
    
    
}
