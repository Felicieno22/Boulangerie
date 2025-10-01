package com.example.boulangerie;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class boulangerieApplication {

	public static void main(String[] args) {
		SpringApplication.run(boulangerieApplication.class, args);
		System.out.println("Hello world in port 8080 bruh!");
	}

}
