package com.example.card_io_setup.Entity;

public class CreditCardEntity {

    private String tckn;
    private String cardNo;
    private String expMonth;
    private String expYear;
    private String cvv;
    private String cardLimit;
    private String debt;
    private String cutOffDate;
    private String paymentDueDate;
    private String wordPoint;
    private boolean contactless;
    private boolean ecom;
    private boolean mailOrder;

    public CreditCardEntity(String tckn, String cardNo, String expMonth, String expYear, String cvv, String cardLimit, String debt, String cutOffDate, String paymentDueDate, String wordPoint, boolean contactless, boolean ecom, boolean mailOrder) {
        this.tckn = tckn;
        this.cardNo = cardNo;
        this.expMonth = expMonth;
        this.expYear = expYear;
        this.cvv = cvv;
        this.cardLimit = cardLimit;
        this.debt = debt;
        this.cutOffDate = cutOffDate;
        this.paymentDueDate = paymentDueDate;
        this.wordPoint = wordPoint;
        this.contactless = contactless;
        this.ecom = ecom;
        this.mailOrder = mailOrder;
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

    public String getCardLimit() {
        return cardLimit;
    }

    public String getDebt() {
        return debt;
    }

    public String getCutOffDate() {
        return cutOffDate;
    }

    public String getPaymentDueDate() {
        return paymentDueDate;
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

    public boolean isMailOrder() {
        return mailOrder;
    }

    @Override
    public String toString() {
        return "CreditCard{" +
                "tckn='" + tckn + '\'' +
                ", cardNo='" + cardNo + '\'' +
                ", expMonth='" + expMonth + '\'' +
                ", expYear='" + expYear + '\'' +
                ", cvv='" + cvv + '\'' +
                ", cardLimit='" + cardLimit + '\'' +
                ", debt='" + debt + '\'' +
                ", cutOffDate='" + cutOffDate + '\'' +
                ", paymentDueDate='" + paymentDueDate + '\'' +
                ", wordPoint='" + wordPoint + '\'' +
                ", contactless=" + contactless +
                ", ecom=" + ecom +
                ", mailOrder=" + mailOrder +
                '}';
    }
}
