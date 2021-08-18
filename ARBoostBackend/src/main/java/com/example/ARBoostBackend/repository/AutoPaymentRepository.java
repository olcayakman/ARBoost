package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.AutoPayment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface AutoPaymentRepository extends JpaRepository<AutoPayment, String> {

    @Query(value = "SELECT * FROM AUTO_PAYMENT WHERE card_no = ?", nativeQuery = true)
    List<AutoPayment> getAutoPaymentByCardNo(String cardNo);
}
