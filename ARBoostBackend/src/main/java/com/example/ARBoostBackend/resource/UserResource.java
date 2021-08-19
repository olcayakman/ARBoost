package com.example.ARBoostBackend.resource;

import com.example.ARBoostBackend.model.User;
import com.example.ARBoostBackend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserResource {

    @Autowired
    UserRepository userRepository;

    @GetMapping("/all")
    public List<User> getAll(){
        return userRepository.findAll();
    }

    @GetMapping("/tckn={tckn}")
    public User getUserById(@PathVariable("tckn") String tckn){
        return userRepository.findById(tckn).get();
    }



    

}
