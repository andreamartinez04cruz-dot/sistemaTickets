/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileTools/Templates/Classes/Interface.java to edit this template
 */
package co.edu.sena.mesa.servicio.asignacion;

import co.edu.sena.mesa.modelo.Ticket;
import co.edu.sena.mesa.modelo.Usuario;
import java.util.List;

/**
 *
 * @author andre
 */
public interface AsignacionStrategy {

	Usuario asignar(Ticket ticket, List<Usuario> agentes);
}
