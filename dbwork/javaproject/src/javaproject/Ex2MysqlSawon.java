package javaproject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Ex2MysqlSawon {

	final static String MYSQL_DRIVER="com.mysql.cj.jdbc.Driver";
	final static String MYSQL_URL="jdbc:mysql://localhost:3306/bit701?serverTimezone=Asia/Seoul";
	
	public Ex2MysqlSawon() {
		try {
			Class.forName(MYSQL_DRIVER);
			System.out.println("Mysql 드라이버 성공");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("Mysql 드라이버 실패:"+e.getMessage());
		}
		
	}
	
	
	public Connection getConnection()
	{
		Connection conn=null;
		try {
			conn=DriverManager.getConnection(MYSQL_URL, "angel", "1234");
//			System.out.println("로칼 Mysql 연결 성공");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("로칼 Mysql 연결 실패:" + e.getMessage());
		}
		return conn;
	}
	
	public void writeSawon()
	{
		Connection conn=this.getConnection();
		String sql="select sawon.num,name,gender,buseo,age,hp,addr,score"
				+ " from sawon"
				+ " inner join sawoninfo on sawon.num=sawoninfo.num";
		Statement stmt=null;
		ResultSet rs=null;
		
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				int num=rs.getInt("num");
				String name=rs.getString("name");
				String gender=rs.getString("gender");
				String buseo=rs.getString("buseo");
				int age=rs.getInt("age");
				String hp=rs.getString("hp");
				String addr=rs.getString("addr");
				int score=rs.getInt("score");
				
				System.out.println("**"+name+" 사원의 개인정보 **");
				System.out.println("num="+num+",score="+score);
				System.out.println("부서명"+buseo+", 성별:"+gender);
				System.out.println("주소:"+addr+",핸드폰:"+hp);
				System.out.println("나이:"+age);
				System.out.println("=".repeat(30));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			} catch(SQLException e) {}
		}
		
	}
	
	
	
	
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Ex2MysqlSawon ex2=new Ex2MysqlSawon();
		ex2.writeSawon();
		ex2.countSawon();
		System.out.println();
		ex2.bunseokSawon();
	}
	
	
	private void bunseokSawon() {
		// TODO Auto-generated method stub
		String sql="select buseo, count(*) count, round(avg(score),1) avgscore, max(score) maxscore,"
				+ "min(score) minscore from sawon group by buseo";
		System.out.println("부서명 인원수 평균점수 최고점수 최저점수");
		System.out.println("=".repeat(60));
		Connection conn=this.getConnection();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				String buseo=rs.getString("buseo");  
				int count=rs.getInt("count");
				double avgscore=rs.getDouble("avgscore");
				int maxscore=rs.getInt("maxscore");
				int minscore=rs.getInt("minscore");
				System.out.printf("%-5s%5d%7.1f%8d%8d\n",buseo,count,avgscore,maxscore,minscore);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			} catch(SQLException e) {}
		}
	}


	private void countSawon() {
		
		String sql="select count(*) cnt from sawon,sawoninfo where sawon.num=sawoninfo.num";
		Connection conn=this.getConnection();
		
		Statement stmt=null;
		ResultSet rs=null;
		
		try {
			stmt=conn.createStatement();
			rs=stmt.executeQuery(sql);
			
			while(rs.next())
			{
				int cnt=rs.getInt("cnt");
				System.out.println("총 "+cnt+"명의 사원이 있습니다");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) rs.close();
				if(stmt!=null) stmt.close();
				if(conn!=null) conn.close();
			} catch(SQLException e) {}
		}
	}
}





