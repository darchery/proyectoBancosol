package es.uma.tsaw.proyectobancosol;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import io.github.cdimascio.dotenv.Dotenv;
import org.springframework.context.annotation.Configuration;

import jakarta.annotation.PostConstruct;

@SpringBootApplication
public class ProyectoBancosolApplication {

    public static void main(String[] args) {
        // Cargar .env ANTES de que Spring arranque
        Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();
        dotenv.entries().forEach(entry ->
                System.setProperty(entry.getKey(), entry.getValue())
        );

        SpringApplication.run(ProyectoBancosolApplication.class, args);
    }

}
