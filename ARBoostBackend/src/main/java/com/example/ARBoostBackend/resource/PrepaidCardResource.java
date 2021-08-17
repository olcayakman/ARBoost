package com.example.ARBoostBackend.resource;

import com.example.ARBoostBackend.model.DebitCard;
import com.example.ARBoostBackend.model.PrepaidCard;
import com.example.ARBoostBackend.model.User;
import com.example.ARBoostBackend.repository.DebitCardRepository;
import com.example.ARBoostBackend.repository.PrepaidCardRepository;
import com.example.ARBoostBackend.repository.UserRepository;
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
    public PrepaidCard getPrepaidCardById(@PathVariable("cardNo") String cardNo){
        return prepaidCardRepository.findById(cardNo).get();
    }

}
