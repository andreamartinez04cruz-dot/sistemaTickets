package co.edu.sena.mesa.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {

    private static final String URL = "jdbc:mysql://localhost:3306/fitcimm";
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    public static Connection obtenerConexion() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("CONECTADO A: " + con.getCatalog());

        } catch (Exception e) {

            e.printStackTrace();

        }

        return con;
    }
}
