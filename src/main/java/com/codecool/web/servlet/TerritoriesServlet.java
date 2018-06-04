package com.codecool.web.servlet;

import com.codecool.web.dao.TerritoriesDao;
import com.codecool.web.model.Territories;
import com.codecool.web.service.TerritoriesService;
import com.codecool.web.service.exception.ServerException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/territoriesServlet")
public class TerritoriesServlet extends AbstractServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try(Connection c = getConnection(req.getServletContext())) {
            TerritoriesDao db = new TerritoriesDao(c);
            TerritoriesService service = new TerritoriesService(db);

            List<Territories> territoriesList = service.getAllTerritories();

            sendMessage(resp, HttpServletResponse.SC_OK, territoriesList);

        } catch (ServerException e){

        } catch (SQLException e){
           handleSqlError(resp, e);
        }
    }
}
