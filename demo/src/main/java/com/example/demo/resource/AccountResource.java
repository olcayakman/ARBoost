package com.example.demo.resource;

import com.example.demo.model.Account;
import com.example.demo.model.DebitCard;
import com.example.demo.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/rest/account")
public class AccountResource {

    @Autowired
    AccountRepository accountRepository;

    @GetMapping("/all")
    public List<Account> getAll(){
        return accountRepository.findAll();
    }

    @GetMapping("/{tckn}")
    public Account getUserById(@PathVariable("tckn") String tckn){
        return accountRepository.findById(tckn).get();
    }
}
