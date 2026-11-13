package org.romero;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class PsicometricApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(PsicometricApplication.class, args);
    }
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application){return application.sources(PsicometricApplication.class);}
}
