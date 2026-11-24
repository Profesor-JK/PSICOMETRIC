package org.romero;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = {"org.romero"})
@EntityScan(basePackages = "org.romero.model")
@EnableJpaRepositories(basePackages = "org.romero.dao")
public class PsicometricApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(PsicometricApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(PsicometricApplication.class);
    }
}
