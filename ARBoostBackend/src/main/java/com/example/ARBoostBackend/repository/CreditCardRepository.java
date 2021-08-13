package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.CreditCard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CreditCardRepository extends JpaRepository<CreditCard, String> {
}
