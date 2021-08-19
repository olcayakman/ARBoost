package com.example.ARBoostBackend.resource;

import com.example.ARBoostBackend.model.Account;
import com.example.ARBoostBackend.model.DebitCard;
import com.example.ARBoostBackend.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/account")
public class AccountResource {

    @Autowired
    AccountRepository accountRepository;

    @GetMapping("/all")
    public List<Account> getAll(){
        return accountRepository.findAll();
    }

    @GetMapping("/tckn={tckn}")
    public Account getAccountById(@PathVariable("tckn") String tckn){
        return accountRepository.findById(tckn).get();
    }
}
