package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.Account;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AccountRepository extends JpaRepository<Account, String> {
}
