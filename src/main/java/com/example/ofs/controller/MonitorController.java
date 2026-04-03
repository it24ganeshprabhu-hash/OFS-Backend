package com.example.ofs.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MonitorController {

    @GetMapping("/ping")
    public String keepAlive() {
        // This confirms the Spring Boot app is active and responding
        return "OFS Backend is Online";
    }
}
