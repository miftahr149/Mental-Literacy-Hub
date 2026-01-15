package my.utm.mentalhealthapp.config;

import my.utm.mentalhealthapp.security.AuthenticationSuccessHandler;
import my.utm.mentalhealthapp.security.CustomUserDetailsService;
import my.utm.mentalhealthapp.security.DelegatingPasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired
    private AuthenticationSuccessHandler authenticationSuccessHandler;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authenticationProvider());
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        // Using DelegatingPasswordEncoder to support both plain text (backward compatibility)
        // and BCrypt (for new passwords)
        return new DelegatingPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests()
                // Public endpoints - authentication pages
                .antMatchers("/auth/**").permitAll().antMatchers("/index.jsp", "/").permitAll()
                .antMatchers("/uploads/**").permitAll()
                // Role-Based Access Control (RBAC)
                // Dashboard - accessible to all authenticated users
                .antMatchers("/dashboard/**").authenticated()
                // Feedback endpoints
                .antMatchers("/feedback/file").hasAnyRole("STUDENT", "MHP")
                .antMatchers("/feedback/my-feedback").hasRole("STUDENT")
                .antMatchers("/feedback/view").hasRole("MHP").antMatchers("/feedback/admin")
                .hasRole("ADMIN").antMatchers("/feedback/**").authenticated()
                // Analytics - Admin only
                .antMatchers("/analytics/**").hasRole("ADMIN")
                // User Management - Profile endpoints accessible to all authenticated users
                .antMatchers("/user-management/profile/**").authenticated()
                // User Management - Admin functions require ADMIN role
                .antMatchers("/user-management/admin/**").hasRole("ADMIN")
                .antMatchers("/user-management/**").authenticated()
                // Challenges - Student and MHP only (Admin excluded)
                .antMatchers("/mental-health-challenge/**").hasAnyRole("STUDENT", "MHP")
                .antMatchers("/challenges/**").hasAnyRole("STUDENT", "MHP")
                // All other requests require authentication
                .anyRequest().authenticated().and().formLogin().loginPage("/auth/login")
                .loginProcessingUrl("/auth/login").usernameParameter("email") // Use email instead
                                                                              // of username
                .passwordParameter("password").successHandler(authenticationSuccessHandler)
                .failureUrl("/auth/login?error=true").permitAll().and().logout()
                .logoutUrl("/auth/logout").logoutSuccessUrl("/auth/login?logout=true")
                .invalidateHttpSession(true).deleteCookies("JSESSIONID").permitAll().and().csrf()
                .disable() // Disable CSRF for form-based authentication (consider enabling for
                           // production)
                .sessionManagement().maximumSessions(1).maxSessionsPreventsLogin(false);
    }
}

