package com.bitrefund.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
public class AppConfig {

	@Autowired
	ApplicationContext applicationContext;
	
	
	@Bean
	public DriverManagerDataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		dataSource.setUrl("jdbc:sqlserver://localhost:1433;databaseName=Bit");
		dataSource.setUsername("SA");
		dataSource.setPassword("Rlarmsejr1");

		return dataSource;
	}

	@Bean
	public DataSourceTransactionManager transactionManager(DataSource dataSource) {
		DataSourceTransactionManager transactionManager = new DataSourceTransactionManager();
		transactionManager.setDataSource(dataSource);

		return transactionManager;
	}

	@Bean
	public SqlSessionFactoryBean sqlSessionFactory(DataSource dataSource) throws Exception{
		System.out.println("sqlSessionFactoryBean()");
		SqlSessionFactoryBean sqlSession = new SqlSessionFactoryBean();

//		이미 등록된 DataSource Bean을 인자값으로 받아와서 사용 또는 dataSource 메서드를 사용
		sqlSession.setDataSource(dataSource);
//		sqlSession.setDataSource(this.dataSource());
//		프로젝트 내의 파일을 읽기 위해서는 applicationContext.getResource
		sqlSession.setConfigLocation(applicationContext.getResource("classpath:mapper/mybatis-config.xml"));
		sqlSession.setMapperLocations(applicationContext.getResources("classpath:mapper/*Mapper.xml"));
		
		return sqlSession;
	}

	@Bean(name = "sqlSession")
	public SqlSessionTemplate sqlSession(SqlSessionFactory sqlSessionFactory){
		System.out.println("seqlSession()");
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
