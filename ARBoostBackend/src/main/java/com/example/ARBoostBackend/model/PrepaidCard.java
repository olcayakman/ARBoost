package com.example.ARBoostBackend.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name= "PREPAID_CARD")
@Getter
public class PrepaidCard {

    @Id
    private String cardNo;
    private String expMonth;
    private String expYear;
    private String cvv;
    private double balance;
    private boolean contactless;
    private boolean ecom;
}
