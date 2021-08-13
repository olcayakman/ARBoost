package com.example.ARBoostBackend.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Entity
@Table(name= "USER")
@Getter
public class User {

    @Id
    private String tckn;
    private String name;
    private String surname;
    private String password;
    private Date birthdate;
}
