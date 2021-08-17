package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {

    @Query(value = "SELECT * FROM TRANSACTION WHERE card_no = ?", nativeQuery = true)
    List<Transaction> getTransactionByCardNo(String cardNo);

}
