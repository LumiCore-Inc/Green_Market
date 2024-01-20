package com.green_market.model;

public class CartModel {
    private int productCartId;
    private int productId;
    private String productName;
    private Double price;
    private String description;
    private String imgUrl;

    public CartModel() {
    }

    public CartModel(int productCartId, int productId, String productName, Double price, String description, String imgUrl) {
        this.productCartId = productCartId;
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.description = description;
        this.imgUrl = imgUrl;
    }

    public int getProductCartId() {
        return productCartId;
    }

    public void setProductCartId(int productCartId) {
        this.productCartId = productCartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }
}
