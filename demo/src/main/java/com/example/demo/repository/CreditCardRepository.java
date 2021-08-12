package com.example.demo.repository;

import com.example.demo.model.CreditCard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CreditCardRepository extends JpaRepository<CreditCard, String> {
}
