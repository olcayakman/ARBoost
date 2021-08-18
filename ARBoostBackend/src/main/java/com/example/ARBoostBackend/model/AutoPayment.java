package com.example.ARBoostBackend.model;

import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name="AUTO_PAYMENT")
@Getter
@NoArgsConstructor
public class AutoPayment {

    @Id
    private String cardNo;
    private String receiver;
    private double amount;
    private String paymentDat;
}
