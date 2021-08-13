package com.example.ARBoostBackend.repository;

import com.example.ARBoostBackend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, String> {

}
