package com.example.card_io_setup.Service;

import com.example.card_io_setup.Entity.PrepaidCard;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface PrepaidCardService {

    @GET("rest/prepaid_card/all")
    Call<List<PrepaidCard>> getAllCards();

    @GET("rest/prepaid_card/{cardNo}")
    Call<PrepaidCard> getPrepaidCardById(@Path("cardNo") String cardNo);

}
