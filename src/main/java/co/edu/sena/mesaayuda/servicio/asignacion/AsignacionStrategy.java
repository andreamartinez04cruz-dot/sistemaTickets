/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileTools/Templates/Classes/Interface.java to edit this template
 */
package co.edu.sena.mesaayuda.servicio.asignacion;

import co.edu.sena.mesaayuda.modelo.Ticket;
import co.edu.sena.mesaayuda.modelo.Usuario;
import java.util.List;

/**
 *
 * @author andre
 */
public interface AsignacionStrategy {

	Usuario asignar(Ticket ticket, List<Usuario> agentes);
}
