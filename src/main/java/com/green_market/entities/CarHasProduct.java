package com.green_market.entities;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "car_has_product")
public class CarHasProduct {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @NotNull
    @Column(name = "cart_id", nullable = false)
    private Integer cartId;

    @NotNull
    @Column(name = "product_id", nullable = false)
    private Integer product;
}