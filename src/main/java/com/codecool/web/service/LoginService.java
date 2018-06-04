package com.codecool.web.service;

import com.codecool.web.dao.UserDao;
import com.codecool.web.model.Supplier;
import com.codecool.web.model.User;
import com.codecool.web.service.exception.ServerException;

import java.sql.SQLException;

public class LoginService {

    private UserDao db;

    public LoginService(UserDao db) {
        this.db = db;
    }

    public User loginEmployee(int id) throws SQLException, ServerException{
        User user = db.getUserByID(id);
        if(user == null){
            throw new ServerException("Id not exist");
        }else {
            return user;
        }
    }

    public Supplier loginSupplier(int id) throws SQLException, ServerException{
        Supplier supplier = db.getSupplierByID(id);
        if(supplier == null){
            throw new ServerException("Id not exist");
        }else {
            return supplier;
        }
    }
}
