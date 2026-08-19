package co.edu.sena.mesaayuda.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConexionBD {

    private static final String URL = "jdbc:mysql://localhost:3306/mesaayuda";
    private static final String USER = "root";
    private static final String PASSWORD = "Sena2026*";

    private static boolean migrado = false;

    public static Connection obtenerConexion() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("CONECTADO A: " + con.getCatalog());

            if (!migrado && con != null) {
                migrarBaseDeDatos(con);
                migrado = true;
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return con;
    }

    private static synchronized void migrarBaseDeDatos(Connection con) {
        String[] columnas = {"programa", "numeroPrograma", "instructor", "jornada"};
        String[] tipos = {"VARCHAR(255)", "VARCHAR(100)", "VARCHAR(255)", "VARCHAR(50)"};

        for (int i = 0; i < columnas.length; i++) {
            String col = columnas[i];
            String tipo = tipos[i];
            try {
                java.sql.DatabaseMetaData dbmd = con.getMetaData();
                try (java.sql.ResultSet rs = dbmd.getColumns(null, null, "ticket", col)) {
                    if (!rs.next()) {
                        try (java.sql.Statement stmt = con.createStatement()) {
                            stmt.execute("ALTER TABLE ticket ADD COLUMN " + col + " " + tipo);
                            System.out.println("MIGRACION: Columna agregada: " + col);
                        }
                    }
                }
            } catch (Exception e) {
                System.out.println("MIGRACION: Error agregando columna " + col + ": " + e.getMessage());
            }
        }
    }
}
