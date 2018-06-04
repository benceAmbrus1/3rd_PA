package com.codecool.web.service;

import com.codecool.web.dao.UserDao;
import com.codecool.web.model.User;

import java.sql.SQLException;
import java.util.List;

public class UserService {

    private UserDao db;

    public UserService(UserDao db) {
        this.db = db;
    }

    public List<User> allSubsById(int id) throws SQLException{
       return db.allSubsByUserId(id);
    }
}
