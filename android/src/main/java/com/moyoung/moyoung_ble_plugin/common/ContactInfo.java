package com.moyoung.moyoung_ble_plugin.common;

import java.util.List;

public class ContactInfo {
    private String name;
    private List<String> number;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<String> getNumber() {
        return number;
    }

    public void setNumber(List<String> number) {
        this.number = number;
    }
}
