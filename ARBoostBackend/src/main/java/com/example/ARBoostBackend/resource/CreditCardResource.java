package com.example.ARBoostBackend.resource;

import com.example.ARBoostBackend.model.CreditCard;
import com.example.ARBoostBackend.model.Transaction;
import com.example.ARBoostBackend.model.User;
import com.example.ARBoostBackend.repository.CreditCardRepository;
import com.example.ARBoostBackend.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/credit_card")
public class CreditCardResource {
    @Autowired
    CreditCardRepository creditCardRepository;

    @GetMapping("/all")
    public List<CreditCard> getAll(){
        return creditCardRepository.findAll();
    }

    @GetMapping("/card_no={cardNo}")
    public CreditCard getCreditCardById(@PathVariable("cardNo") String cardNo){
        return creditCardRepository.findById(cardNo).get();
    }

    @GetMapping("/tckn={tckn}")
    public List<String> getCardNoFromTckn(@PathVariable("tckn") String tckn){
        return creditCardRepository.getCardNoByTckn(tckn);
    }

}
