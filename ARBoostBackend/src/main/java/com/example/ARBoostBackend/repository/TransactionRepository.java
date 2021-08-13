package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
}
