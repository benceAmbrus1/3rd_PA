package com.codecool.web.model;

public final class User extends AbstractModel {

    private final String fName;
    private final String lName;
    private final String title;

    public User(int id, String fName, String lName, String title) {
        super(id);
        this.fName = fName;
        this.lName = lName;
        this.title = title;
    }

    public String getfName() {
        return fName;
    }

    public String getlName() {
        return lName;
    }

    public String getTitle() {
        return title;
    }

}
