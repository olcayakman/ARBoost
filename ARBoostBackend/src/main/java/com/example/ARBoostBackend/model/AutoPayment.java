package com.example.ARBoostBackend.model;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;


@Entity
@Table(name="auto_payment")
@Getter
@NoArgsConstructor
public class AutoPayment {


    @Id
    @Column(columnDefinition = "payment_id")
    private Long paymentId;


    @Column(columnDefinition = "card_no")
    private String cardNo;
    @Column(columnDefinition = "receiver")
    private String receiver;
    @Column(columnDefinition = "amount")
    private double amount;
    @Column(columnDefinition = "payment_day")
    private int paymentDay;

}
