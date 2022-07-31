package util;

import java.sql.Connection;
import java.sql.DriverManager;
public class DatabaseUtil {
	public static Connection getConnection() {
        try {
        	//한글 인코딩 부분 추가해줘야. 쿼리 실행할때 executeQuery()에서 한글이 깨지지 않고 조회해옴. 인코딩 안하면 인코딩 오류 안나고,조회 못함.(한글 인코딩 오류 안나서 찾기 힘듦...)
			//String dbURL = "jdbc:mysql://54.180.61.247:3306/freeze_db?useUnicode=true&characterEncoding=UTF8";
			String dbURL = "jdbc:mysql://localhost:3306/freeze_db?useUnicode=true&characterEncoding=utf8";
            String dbID = "root"; 
            String dbPassword = "eownwnsla12";
            Class.forName("com.mysql.jdbc.Driver"); 
            return DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e) {
          e.printStackTrace();
        }
        return null;
      }
}

