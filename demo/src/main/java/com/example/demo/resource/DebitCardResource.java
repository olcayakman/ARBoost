package com.example.demo.resource;

import com.example.demo.model.DebitCard;
import com.example.demo.model.User;
import com.example.demo.repository.DebitCardRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/rest/debit_card")
public class DebitCardResource {
    @Autowired
    DebitCardRepository debitCardRepository;

    @GetMapping("/all")
    public List<DebitCard> getAll(){
        return debitCardRepository.findAll();
    }

    @GetMapping("/{cardNo}")
    public DebitCard getUserById(@PathVariable("cardNo") String cardNo){
        return debitCardRepository.findById(cardNo).get();
    }
}
