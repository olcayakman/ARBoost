package com.example.demo.resource;

import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rest/user")
public class UserResource {

    @Autowired
    UserRepository userRepository;

    @GetMapping("/all")
    public List<User> getAll(){
        return userRepository.findAll();
    }

    @GetMapping("/{tckn}")
    public User getUserById(@PathVariable("tckn") String tckn){
        return userRepository.findById(tckn).get();
    }

    

}
