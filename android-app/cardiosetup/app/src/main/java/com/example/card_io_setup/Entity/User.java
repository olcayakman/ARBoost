package com.example.card_io_setup.Entity;


public class User {
    private String tckn;
    private String name;
    private String surname;
    private String password;
    private String birthdate;

    public User(String tckn, String name, String surname, String password, String birthdate) {
        this.tckn = tckn;
        this.name = name;
        this.surname = surname;
        this.password = password;
        this.birthdate = birthdate;
    }

    public String getTckn() {
        return tckn;
    }

    public String getName() {
        return name;
    }

    public String getSurname() {
        return surname;
    }

    public String getPassword() {
        return password;
    }

    public String getBirthdate() {
        return birthdate;
    }

    @Override
    public String toString() {
        return "User{" +
                "tckn='" + tckn + '\'' +
                ", name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", password='" + password + '\'' +
                ", birthdate=" + birthdate +
                '}';
    }
}