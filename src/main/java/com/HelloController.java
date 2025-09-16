package com.example.demo;
 
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
 
@RestController
public class HelloController {
 
    @GetMapping("/hello")
    public String hello() {
        return "🚀 Hello from Java CI/CD Pipeline with Jenkins, SonarQube, Trivy & AWS!";
    }
}