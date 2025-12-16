package com.shipping;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
@MapperScan("com.shipping.mapper")
public class ShippingSystemApplication {
    public static void main(String[] args) {
        SpringApplication.run(ShippingSystemApplication.class, args);
    }
} 