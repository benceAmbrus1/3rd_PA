package com.codecool.web.servlet;

import com.codecool.web.dao.UserDao;
import com.codecool.web.model.User;
import com.codecool.web.service.UserService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/subordinatesServlet")
public class SubordinatesServlet extends AbstractServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try(Connection c = getConnection(req.getServletContext())) {
            UserDao db = new UserDao(c);
            UserService service = new UserService(db);

            User user = (User) req.getSession().getAttribute("user");
            int userId = user.getId();
            List<User> subList = service.allSubsById(userId);

            sendMessage(resp, HttpServletResponse.SC_OK, subList);

        } catch (SQLException e){
            handleSqlError(resp, e);
        }
    }
}
