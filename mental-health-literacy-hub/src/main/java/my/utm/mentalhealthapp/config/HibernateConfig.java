package my.utm.mentalhealthapp.config;

import java.util.Properties;
import javax.sql.DataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = { "my.utm.mentalhealthapp.service", "my.utm.mentalhealthapp.entity",
        "my.utm.mentalhealthapp.dao", "my.utm.mentalhealthapp.controller" })
public class HibernateConfig {
    private static String MYSQL_USERNAME = "root";
    private static String MYSQL_PASSWORD = "admin123";

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setUrl(
  "jdbc:mysql://localhost:3306/mentalhealth_db" +
  "?useSSL=false" +
  "&allowPublicKeyRetrieval=true" +
  "&serverTimezone=UTC"
);

        dataSource.setUsername("root");
        // dataSource.setPassword("admin123");

        return dataSource;
    }

    @Bean
    public LocalSessionFactoryBean sessionFactory() {
        LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();
        sessionFactoryBean.setDataSource(this.dataSource());
        sessionFactoryBean.setPackagesToScan("my.utm.mentalhealthapp.entity");

        Properties hibernateProperties = new Properties();
        hibernateProperties.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL8Dialect");
        hibernateProperties.setProperty("hibernate.show_sql", "true");
        hibernateProperties.setProperty("hibernate.hbm2ddl.auto", "update");

        sessionFactoryBean.setHibernateProperties(hibernateProperties);
        return sessionFactoryBean;
    }

    @Bean
    public HibernateTransactionManager transactionManager(LocalSessionFactoryBean sessionFactory) {
        return new HibernateTransactionManager(sessionFactory.getObject());
    }
}
