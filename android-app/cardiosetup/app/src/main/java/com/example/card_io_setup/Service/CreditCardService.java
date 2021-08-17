package com.example.card_io_setup.Service;

import com.example.card_io_setup.Entity.CreditCardEntity;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface CreditCardService {

    @GET("rest/credit_card/all")
    Call<List<CreditCardEntity>> getAllCards();

    @GET("rest/credit_card/{cardNo}")
    Call<CreditCardEntity> getCreditCardById(@Path("cardNo") String cardNo);


    @GET("rest/credit_card/tc/{tckn}")
    Call<String> getCardNoFromTckn(@Path("tckn") String tckn);

}
