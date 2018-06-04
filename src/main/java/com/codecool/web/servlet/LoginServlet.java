package com.codecool.web.servlet;

import com.codecool.web.dao.UserDao;
import com.codecool.web.model.Supplier;
import com.codecool.web.model.User;
import com.codecool.web.service.LoginService;
import com.codecool.web.service.exception.ServerException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/loginServlet")
public final class LoginServlet extends AbstractServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        try (Connection connection = getConnection(req.getServletContext())) {
            UserDao userDao = new UserDao(connection);
            LoginService loginService = new LoginService(userDao);

            String type = req.getParameter("type");
            int id = Integer.parseInt(req.getParameter("id"));

            if(type.equals("employee")){
                User user = loginService.loginEmployee(id);
                req.getSession().setAttribute("user", user);
                req.setAttribute("user", user);
                req.getRequestDispatcher("employee.jsp").forward(req, resp);
            }else{
                Supplier supplier = loginService.loginSupplier(id);
                req.getSession().setAttribute("supplier", supplier);
                req.setAttribute("supplier", supplier);
                req.getRequestDispatcher("supplier.jsp").forward(req, resp);
            }


        } catch (ServerException ex) {
            req.setAttribute("error", ex);
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } catch (SQLException ex) {
            handleSqlError(resp, ex);
        }
    }
}
