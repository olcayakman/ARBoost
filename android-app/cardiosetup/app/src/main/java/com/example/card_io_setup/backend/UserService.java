package com.example.card_io_setup.backend;

import com.example.card_io_setup.Entity.User;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;

public interface UserService {

    @GET("rest/user/all")
    Call<List<User>> getAllUsers();

}
