package com.example.ARBoostBackend.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name= "DEBIT_CARD")
@Getter
public class DebitCard {


    private String tckn;
    @Id
    private String cardNo;
    private String expMonth;
    private String expYear;
    private String cvv;
    private double balance;
    private double wordPoint;
    private boolean contactless;
    private boolean ecom;
    private boolean mailOrder;
}
