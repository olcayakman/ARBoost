package com.example.card_io_setup.Entity;

public class DebitCard {
    private String tckn;
    private String cardNo;
    private String expMonth;
    private String expYear;
    private String cvv;
    private String balance;
    private String wordPoint;
    private boolean contactless;
    private boolean ecom;

    public DebitCard(String tckn, String cardNo, String expMonth, String expYear, String cvv, String balance, String wordPoint, boolean contactless, boolean ecom) {
        this.tckn = tckn;
        this.cardNo = cardNo;
        this.expMonth = expMonth;
        this.expYear = expYear;
        this.cvv = cvv;
        this.balance = balance;
        this.wordPoint = wordPoint;
        this.contactless = contactless;
        this.ecom = ecom;
    }

    public String getTckn() {
        return tckn;
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

    public String getWordPoint() {
        return wordPoint;
    }

    public boolean isContactless() {
        return contactless;
    }

    public boolean isEcom() {
        return ecom;
    }

    @Override
    public String toString() {
        return "DebitCard{" +
                "tckn='" + tckn + '\'' +
                ", cardNo='" + cardNo + '\'' +
                ", expMonth='" + expMonth + '\'' +
                ", expYear='" + expYear + '\'' +
                ", cvv='" + cvv + '\'' +
                ", balance='" + balance + '\'' +
                ", wordPoint='" + wordPoint + '\'' +
                ", contactless=" + contactless +
                ", ecom=" + ecom +
                '}';
    }
}
