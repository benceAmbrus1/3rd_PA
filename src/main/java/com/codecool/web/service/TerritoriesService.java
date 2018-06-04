package com.codecool.web.service;

import com.codecool.web.dao.TerritoriesDao;
import com.codecool.web.model.Territories;
import com.codecool.web.service.exception.ServerException;

import java.sql.SQLException;
import java.util.List;

public class TerritoriesService {

    private TerritoriesDao db;

    public TerritoriesService(TerritoriesDao db) {
        this.db = db;
    }

    public List<Territories> getAllTerritories() throws SQLException, ServerException{
        List<Territories> territories = db.getTerritories();
        if(territories == null){
            throw new ServerException("There is no territories");
        }
        return territories;
    }
}
