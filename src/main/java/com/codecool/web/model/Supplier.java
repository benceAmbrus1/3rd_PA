package com.codecool.web.model;

public class Supplier extends AbstractModel {

    private final String companyName;
    private final String contactName;
    private final String contactTitle;

    public Supplier(int id, String companyName, String contactName, String contactTitle) {
        super(id);
        this.companyName = companyName;
        this.contactName = contactName;
        this.contactTitle = contactTitle;
    }

    public String getCompanyName() {
        return companyName;
    }

    public String getContactName() {
        return contactName;
    }

    public String getContactTitle() {
        return contactTitle;
    }
}
