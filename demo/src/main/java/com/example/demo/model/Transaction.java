package com.example.demo.model;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name= "TRANSACTION")
@Getter
@NoArgsConstructor
public class Transaction {

    @Id
    @Column(columnDefinition = "transaction_id")
    private Long transactionId;

    @Column(columnDefinition = "card_no")
    private String cardNo;
    @Column(columnDefinition = "sender")
    private String sender;
    @Column(columnDefinition = "receiver")
    private String receiver;
    @Column(columnDefinition = "amount")
    private double amount;
    @Column(columnDefinition = "card_no")
    private Date transactionDate;

}
