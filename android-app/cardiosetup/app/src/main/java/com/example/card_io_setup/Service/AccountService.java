package com.example.card_io_setup.Service;

import com.example.card_io_setup.Entity.Account;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface AccountService {

    @GET("rest/account/all")
    Call<List<Account>> getAllAccounts();

    @GET("rest/account/{tckn}")
    Call<Account> getAccountById(@Path("tckn") String tckn);
}
