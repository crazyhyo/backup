package kr.or.ddit.util;

import org.apache.ibatis.session.SqlSessionFactory;

public class SingletonOracleMyBatisSqlSessionFactory {
	
	private static SqlSessionFactory factory;
	
	private SingletonOracleMyBatisSqlSessionFactory() {}
	
	public static SqlSessionFactory getInstance() {
		if(factory == null) {
			System.out.println("최초 OracleMyBatisSqlSessionFactory객체 생성 및 반환");
			factory = new OracleMyBatisSqlSessionFactory();
			return factory;
		}else {
			System.out.println("기존 OracleMyBatisSqlSessionFactory 반환");
			return factory;
		}
		
	}
	
}
