package com.codecool.web.model;

public class Territories extends AbstractModel {

    private String terrDesc;
    private int regId;
    private String regDesc;

    public Territories(int id, String terrDesc, int regId, String regDesc) {
        super(id);
        this.terrDesc = terrDesc;
        this.regId = regId;
        this.regDesc = regDesc;
    }

    public String getTerrDesc() {
        return terrDesc;
    }

    public int getRegId() {
        return regId;
    }

    public String getRegDesc() {
        return regDesc;
    }
}
