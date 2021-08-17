package com.example.card_io_setup.Entity;

public class PrepaidCard {
    private String cardNo;
    private String expMonth;
    private String expYear;
    private String cvv;
    private String balance;
    private boolean contactless;
    private boolean ecom;

    public PrepaidCard(String cardNo, String expMonth, String expYear, String cvv, String balance, boolean contactless, boolean ecom) {
        this.cardNo = cardNo;
        this.expMonth = expMonth;
        this.expYear = expYear;
        this.cvv = cvv;
        this.balance = balance;
        this.contactless = contactless;
        this.ecom = ecom;
    }

    public String getCardNo() {
        return cardNo;
    }

    public String getExpMonth() {
        return expMonth;
    }

    public String getExpYear() {
        return expYear;
    }

    public String getCvv() {
        return cvv;
    }

    public String getBalance() {
        return balance;
    }

    public boolean isContactless() {
        return contactless;
    }

    public boolean isEcom() {
        return ecom;
    }

    @Override
    public String toString() {
        return "PrepaidCard{" +
                "cardNo='" + cardNo + '\'' +
                ", expMonth='" + expMonth + '\'' +
                ", expYear='" + expYear + '\'' +
                ", cvv='" + cvv + '\'' +
                ", balance='" + balance + '\'' +
                ", contactless=" + contactless +
                ", ecom=" + ecom +
                '}';
    }
}
