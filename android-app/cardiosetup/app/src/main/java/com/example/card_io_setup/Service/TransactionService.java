package com.example.card_io_setup.Service;


import com.example.card_io_setup.Entity.Transaction;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface TransactionService {

    @GET("rest/transaction/all")
    Call<List<Transaction>> getAllTransactions();

    @GET("rest/transaction/id/{id}")
    Call<Transaction> getTransactionById(@Path("id") String id);

    @GET("rest/transaction/{cardNo}")
    Call<List<Transaction>> getTransactionByCardNo(@Path("cardNo") String cardNo);
}
