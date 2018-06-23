/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Factory;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Pablo
 */
public final class PostgresqlFactory extends ConectionDB{

    //Constructor
    public PostgresqlFactory(String[] params) 
    {
        this.params = params;
        this.open();
    }

    @Override
    public Connection open() 
    {
        try
        {
            Class.forName("org.postgresql.Driver");
            this.connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/"+this.params[0],this.params[1], this.params[2]);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return this.connection;
    }
    
}
