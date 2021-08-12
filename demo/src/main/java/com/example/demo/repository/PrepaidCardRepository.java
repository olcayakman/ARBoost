package com.example.demo.repository;

import com.example.demo.model.PrepaidCard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PrepaidCardRepository extends JpaRepository<PrepaidCard, String> {

}
