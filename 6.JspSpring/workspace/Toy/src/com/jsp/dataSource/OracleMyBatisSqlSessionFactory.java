package com.jsp.dataSource;

import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ExecutorType;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.session.TransactionIsolationLevel;

public class OracleMyBatisSqlSessionFactory implements SqlSessionFactory {

	SqlSessionFactory sessionFactory;
	
	{
		String config = "com/jsp/myBatis/config/sqlConfig.xml";
		
		try {
			Reader reader = Resources.getResourceAsReader(config);
			sessionFactory = new SqlSessionFactoryBuilder().build(reader);
			System.out.println("sqlSessionFactory 생성 성공");
			reader.close();
		} catch (IOException e) {
			System.out.println("sqlSessionFactory 생성 실패");
			e.printStackTrace();
		}
		
	}
	
	@Override
	public Configuration getConfiguration() {
		return sessionFactory.getConfiguration();
	}

	@Override
	public SqlSession openSession() {
		return sessionFactory.openSession(true);
	}

	@Override
	public SqlSession openSession(boolean arg0) {
		return sessionFactory.openSession(arg0);
	}

	@Override
	public SqlSession openSession(Connection arg0) {
		return sessionFactory.openSession(arg0);
	}

	@Override
	public SqlSession openSession(TransactionIsolationLevel arg0) {
		return sessionFactory.openSession(arg0);
	}

	@Override
	public SqlSession openSession(ExecutorType arg0) {
		return sessionFactory.openSession(arg0);
	}

	@Override
	public SqlSession openSession(ExecutorType arg0, boolean arg1) {
		return sessionFactory.openSession(arg0, arg1);
	}

	@Override
	public SqlSession openSession(ExecutorType arg0, TransactionIsolationLevel arg1) {
		return sessionFactory.openSession(arg0, arg1);
	}

	@Override
	public SqlSession openSession(ExecutorType arg0, Connection arg1) {
		return sessionFactory.openSession(arg0, arg1);
	}

}
