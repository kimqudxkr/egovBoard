package egovframework.example.sample.web;

import java.sql.Connection;

import java.sql.DriverManager;



import org.junit.Test;



public class MariaDBConnectionTest {

	private static final String DRIVER = "org.mariadb.jdbc.Driver";
	private static final String URL = "jdbc:mariadb://127.0.0.1:3306/test";
	private static final String USER = "root"; //db 접속 id
	private static final String PW = "root"; //db 접속 password

	@Test
	public void testConnection() throws Exception{
		Class.forName(DRIVER);

		try(Connection con = DriverManager.getConnection(URL, USER, PW)){
			System.out.println("Sueccess!!");
			System.out.println(con);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}