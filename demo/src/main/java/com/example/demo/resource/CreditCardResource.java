package com.example.demo.resource;

import com.example.demo.model.CreditCard;
import com.example.demo.model.User;
import com.example.demo.repository.CreditCardRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/rest/credit_card")
public class CreditCardResource {
    @Autowired
    CreditCardRepository creditCardRepository;

    @GetMapping("/all")
    public List<CreditCard> getAll(){
        return creditCardRepository.findAll();
    }

    @GetMapping("/{cardNo}")
    public CreditCard getUserById(@PathVariable("cardNo") String cardNo){
        return creditCardRepository.findById(cardNo).get();
    }



}
