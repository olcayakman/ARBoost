package com.example.card_io_setup.Service;

import com.example.card_io_setup.Entity.User;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface UserService {

    @GET("rest/user/all")
    Call<List<User>> getAllUsers();
    
    @GET("rest/user/{tckn}")
    Call<User> getUserByTckn(@Path("tckn") String tckn);
}
