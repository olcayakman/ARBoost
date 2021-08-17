package com.example.card_io_setup.Entity;

public class Transaction {
    private String transactionId;
    private String cardNo;
    private String sender;
    private String receiver;
    private String amount;
    private String transactionDate;

    public Transaction(String transactionId, String cardNo, String sender, String receiver, String amount, String transactionDate) {
        this.transactionId = transactionId;
        this.cardNo = cardNo;
        this.sender = sender;
        this.receiver = receiver;
        this.amount = amount;
        this.transactionDate = transactionDate;
    }

    public String getCardNo() {
        return cardNo;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public String getSender() {
        return sender;
    }

    public String getReceiver() {
        return receiver;
    }

    public String getAmount() {
        return amount;
    }

    public String getTransactionDate() {
        return transactionDate;
    }

    @Override
    public String toString() {
        return "Transaction{" +
                "transactionId='" + transactionId + '\'' +
                ", cardNo='" + cardNo + '\'' +
                ", sender='" + sender + '\'' +
                ", receiver='" + receiver + '\'' +
                ", amount='" + amount + '\'' +
                ", transactionDate='" + transactionDate + '\'' +
                '}';
    }
}
