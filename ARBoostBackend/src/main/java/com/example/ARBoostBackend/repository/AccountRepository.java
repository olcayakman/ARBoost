package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.Account;
import com.example.ARBoostBackend.model.AutoPayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AccountRepository extends JpaRepository<Account, String> {

}
