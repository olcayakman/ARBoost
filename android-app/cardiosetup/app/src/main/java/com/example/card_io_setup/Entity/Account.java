package com.example.card_io_setup.Entity;

public class Account {
    private String tckn;
    private String iban;
    private double balance;
    private String cardNo;

    public Account(String tckn, String iban, double balance, String cardNo) {
        this.tckn = tckn;
        this.iban = iban;
        this.balance = balance;
        this.cardNo = cardNo;
    }

    public String getTckn() {
        return tckn;
    }

    public String getIban() {
        return iban;
    }

    public double getBalance() {
        return balance;
    }

    public String getCardNo() {
        return cardNo;
    }

    @Override
    public String toString() {
        return "Account{" +
                "tckn='" + tckn + '\'' +
                ", iban='" + iban + '\'' +
                ", balance=" + balance +
                ", cardNo='" + cardNo + '\'' +
                '}';
    }
}
