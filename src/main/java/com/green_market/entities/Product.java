package com.green_market.entities;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Integer id;

    @Size(max = 255)
    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @NotNull
    @Column(name = "price", nullable = false)
    private Double price;

    @NotNull
    @Column(name = "ratings", nullable = false)
    private Double ratings;

    @NotNull
    @Column(name = "created_user", nullable = false)
    private Integer createdUser;

    @NotNull
    @Column(name = "description", nullable = false)
    private String description;
}