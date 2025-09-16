package com.example.demo;
 
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
 
@SpringBootApplication
public class App {
    public static void main(String[] args) {
        System.out.println("Hello from CodeBuild CI/CD Pipeline!");
        SpringApplication.run(App.class, args);
    }
}