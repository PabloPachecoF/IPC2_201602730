/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Factory;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Pablo
 */
public abstract class ConectionDB {
    
    //Atributos de trabajo
    protected String[] params;
    protected Connection connection;
    
    //Método que devuelve objeto connection
    abstract Connection open();
    
    //Método para recibir y ejectutar querys
    public ResultSet query(String query){
        //Ejecutar query
        Statement st;    
        //Alacenamiento temporal de datos de la DB
        ResultSet rs = null;
        
        //Método
        try
        {
            st =  connection.createStatement();
            rs =  st.executeQuery(query);
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return rs;
    }
    
    //Método boolean
    public boolean execute(String query){
        //Ejecutar query
        Statement st;    
        //Alacenamiento temporal de datos de la DB
        boolean save = true;
        
        //Método
        try
        {
            st =  connection.createStatement();
            st.executeUpdate(query);
        }
        catch(SQLException e)
        {
            save = false;
            e.printStackTrace();
        }
        return save;
    }
    
    //Método de cierre de conexión
    public boolean close()
    {
        boolean ok = true;
        
        try
        {
            connection.close();
        }
        catch (Exception e)
        {
            ok = false;
            e.printStackTrace();
        }
        return ok;
    }
}
