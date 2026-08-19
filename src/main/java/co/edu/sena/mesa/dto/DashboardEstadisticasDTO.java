package co.edu.sena.mesa.dto;

public class DashboardEstadisticasDTO {

    private int totalTicketsMes;
    private int sinAsignar;
    private int criticos;
    private int cerradosHoy;

    public DashboardEstadisticasDTO() {
    }

    public int getTotalTicketsMes() {
        return totalTicketsMes;
    }

    public void setTotalTicketsMes(int totalTicketsMes) {
        this.totalTicketsMes = totalTicketsMes;
    }

    public int getSinAsignar() {
        return sinAsignar;
    }

    public void setSinAsignar(int sinAsignar) {
        this.sinAsignar = sinAsignar;
    }

    public int getCriticos() {
        return criticos;
    }

    public void setCriticos(int criticos) {
        this.criticos = criticos;
    }

    public int getCerradosHoy() {
        return cerradosHoy;
    }

    public void setCerradosHoy(int cerradosHoy) {
        this.cerradosHoy = cerradosHoy;
    }
}
