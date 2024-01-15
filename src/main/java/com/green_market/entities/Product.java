package com.green_market.entities;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

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

    @NotNull
    @Column(name = "qty", nullable = false)
    private Integer qty;

    @Column(name = "description", nullable = false)
    private List<ProductHasImage> productHasImages;

    public Product() {
    }

    public Product(Integer id, String name, Double price, Double ratings, Integer createdUser, String description, Integer qty, List<ProductHasImage> productHasImages) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.ratings = ratings;
        this.createdUser = createdUser;
        this.description = description;
        this.qty = qty;
        this.productHasImages = productHasImages;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getRatings() {
        return ratings;
    }

    public void setRatings(Double ratings) {
        this.ratings = ratings;
    }

    public Integer getCreatedUser() {
        return createdUser;
    }

    public void setCreatedUser(Integer createdUser) {
        this.createdUser = createdUser;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public List<ProductHasImage> getProductHasImages() {
        return productHasImages;
    }

    public void setProductHasImages(List<ProductHasImage> productHasImages) {
        this.productHasImages = productHasImages;
    }
}