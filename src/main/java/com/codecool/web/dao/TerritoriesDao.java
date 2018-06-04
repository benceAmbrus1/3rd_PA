package com.codecool.web.dao;

import com.codecool.web.model.Territories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TerritoriesDao extends AbstractDao{

    public TerritoriesDao(Connection connection) {
        super(connection);
    }

    public List<Territories> getTerritories() throws SQLException{
        List<Territories> territories = new ArrayList<>();
        String sql = "SELECT territory_id, territory_description, territories.region_id, region_description FROM territories" +
            " JOIN region" +
            " ON territories.region_id = region.region_id";
        try (PreparedStatement statement = connection.prepareStatement(sql)){
            ResultSet resultSet = statement.executeQuery();
            while(resultSet.next()){
                territories.add(createTerr(resultSet));
            }
        }
        return territories;
    }

    public Territories createTerr(ResultSet rs) throws SQLException{
        int terrId = rs.getInt("territory_id");
        String terrDesc = rs.getString("territory_description");
        int regId = rs.getInt("region_id");
        String regDesc = rs.getString("region_description");
        return new Territories(terrId, terrDesc, regId, regDesc);
    }
}
