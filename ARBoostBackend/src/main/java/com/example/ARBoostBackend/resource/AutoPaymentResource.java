package com.example.ARBoostBackend.resource;

import com.example.ARBoostBackend.model.AutoPayment;
import com.example.ARBoostBackend.repository.AutoPaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/rest/auto_payment")
public class AutoPaymentResource {

    @Autowired
    AutoPaymentRepository autoPaymentRepository;

    @GetMapping("/all")
    public List<AutoPayment> getAll(){
        return autoPaymentRepository.findAll();
    }

    @GetMapping("/{cardNo}")
    public List<AutoPayment> getPaymentByCardNo(@PathVariable("cardNo") String cardNo){
        return autoPaymentRepository.getAutoPaymentByCardNo(cardNo);
    }



}
