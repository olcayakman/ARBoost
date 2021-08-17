package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.CreditCard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CreditCardRepository extends JpaRepository<CreditCard, String> {

    @Query(value="SELECT card_no FROM CREDIT_CARD WHERE tckn =? ",nativeQuery=true)
    List<String> getCardNoByTckn(String tckn);
}
