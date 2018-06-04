package com.codecool.web.dao;

import com.codecool.web.model.Supplier;
import com.codecool.web.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao extends AbstractDao {

    public UserDao(Connection connection) {
        super(connection);
    }

    public User getUserByID(int id) throws SQLException{
        String sql = "SELECT * FROM employees WHERE employee_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                return createUser(resultSet);
            }
        }
        return null;
    }

    private User createUser(ResultSet rs) throws SQLException{
        int id = rs.getInt("employee_id");
        String fName = rs.getString("first_name");
        String lName = rs.getString("last_name");
        String title = rs.getString("title");
        return new User(id, fName, lName, title);
    }

    public Supplier getSupplierByID(int id) throws SQLException{
        String sql = "SELECT * FROM suppliers WHERE supplier_id = ?;";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            if(resultSet.next()){
                return createSupplier(resultSet);
            }
        }
        return null;
    }

    private Supplier createSupplier(ResultSet rs) throws SQLException{
        int id = rs.getInt("supplier_id");
        String compName = rs.getString("company_name");
        String contName = rs.getString("contact_name");
        String contTitle = rs.getString("contact_title");
        return new Supplier(id, compName, contName, contTitle);
    }

    public List<User> allSubsByUserId(int id) throws SQLException{
        String sql = "SELECT * FROM employees WHERE reports_to = ?;";
        List<User> subs = new ArrayList<>();
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            statement.setInt(1,id);
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                subs.add(createUser(resultSet));
            }
        }
        return subs;
    }
}
