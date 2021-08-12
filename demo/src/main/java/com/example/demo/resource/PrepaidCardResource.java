package com.example.demo.resource;

import com.example.demo.model.DebitCard;
import com.example.demo.model.PrepaidCard;
import com.example.demo.model.User;
import com.example.demo.repository.DebitCardRepository;
import com.example.demo.repository.PrepaidCardRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/rest/prepaid_card")
public class PrepaidCardResource {
    @Autowired
    PrepaidCardRepository prepaidCardRepository;

    @GetMapping("/all")
    public List<PrepaidCard> getAll(){
        return prepaidCardRepository.findAll();
    }

    @GetMapping("/{cardNo}")
    public PrepaidCard getUserById(@PathVariable("cardNo") String cardNo){
        return prepaidCardRepository.findById(cardNo).get();
    }

}
