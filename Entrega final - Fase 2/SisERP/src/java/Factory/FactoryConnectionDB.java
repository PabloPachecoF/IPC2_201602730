/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Factory;

/**
 *
 * @author Pablo
 */
public class FactoryConnectionDB {
    
    public static final int PGSQL = 2;
    public static String[] configPGSQL = {"SistemaERP", "postgres", "sql"};
    
    public static ConectionDB open(int typeDB)
    {
        switch(typeDB)
        {
            case FactoryConnectionDB.PGSQL:
                return new PostgresqlFactory(configPGSQL);
            
            default:
                return null;        
        }
    }
    
}
