/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package co.edu.sena.mesa.modelo;

import java.time.LocalDateTime;

/**
 *
 * @author Doris López
 */
public class Comentario {

    private int id;
    private Usuario usuario; // para el id del solicitante
    private String texto;
    private LocalDateTime fecha;
    
     public Comentario () {
         
     }

    public Comentario(int id, Usuario usuario, String texto, LocalDateTime fecha) {
        this.id = id;
        this.usuario = usuario;
        this.texto = texto;
        this.fecha = fecha;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public LocalDateTime getFecha() {
        return fecha;
    }

    public void setFecha(LocalDateTime fecha) {
        this.fecha = fecha;
    }

}
