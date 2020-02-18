package project;

import java.sql.*;

public class DBcon_bean {
	Connection con = null;
	String driverName = "com.mysql.jdbc.Driver";
	String dbURL = "jdbc:mysql://localhost/project";

public Connection getConnection()
	{
		try {
			Class.forName(driverName);
			con = DriverManager.getConnection(dbURL, "root", "qlalfqjsgh1!");
		} catch (SQLException e) {
			System.out.println(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}
}