package com.example.demo.model;

import lombok.Getter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name= "ACCOUNT")
@Getter
public class Account {

    @Id
    private String tckn;
    private String iban;
    private double balance;
    private String cardNo;
}
