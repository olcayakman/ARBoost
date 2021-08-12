package com.example.demo.repository;

import com.example.demo.model.DebitCard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DebitCardRepository extends JpaRepository<DebitCard, String> {
}
