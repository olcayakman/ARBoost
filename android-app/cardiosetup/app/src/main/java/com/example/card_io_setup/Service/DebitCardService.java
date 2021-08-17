package com.example.card_io_setup.Service;

import com.example.card_io_setup.Entity.DebitCard;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface DebitCardService {

    @GET("rest/debit_card/all")
    Call<List<DebitCard>> getAllCards();

    @GET("rest/debit_card/{cardNo}")
    Call<DebitCard> getDebitCardById(@Path("cardNo") String cardNo);

    @GET("rest/debit_card/tc/{tckn}")
    Call<String> getCardNoFromTckn(@Path("tckn") String tckn);


}
