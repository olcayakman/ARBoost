package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.DebitCard;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DebitCardRepository extends JpaRepository<DebitCard, String> {

    @Query(value="SELECT card_no FROM DEBIT_CARD WHERE tckn =? ",nativeQuery=true)
    List<String> getCardNoByTckn(String tckn);
}
