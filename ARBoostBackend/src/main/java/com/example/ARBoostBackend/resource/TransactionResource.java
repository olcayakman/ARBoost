package com.example.ARBoostBackend.resource;

import com.example.ARBoostBackend.model.Transaction;
import com.example.ARBoostBackend.model.User;
import com.example.ARBoostBackend.repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/rest/transaction")
public class TransactionResource {

    @Autowired
    TransactionRepository transactionRepository;

    @GetMapping("/all")
    public List<Transaction> getAll(){
        return transactionRepository.findAll();
    }

    @GetMapping("/id/{id}")
    public Transaction getUserById(@PathVariable("id") Long id){
        return transactionRepository.findById(id).get();
    }

    @GetMapping("/{cardNo}")
    public List<Transaction> getTransactionByCardNo(@PathVariable("cardNo") String cardNo){
        List<Transaction> transactions = transactionRepository.findAll();
        List<Transaction> returns = new ArrayList<>();

        for (Transaction t : transactions){
            if(t.getCardNo().equals(cardNo)){
                returns.add(t);
            }
        }
        returns.sort((o2,o1) -> o1.getTransactionDate().compareTo(o2.getTransactionDate()));
        return returns;
    }

}
