package com.bupt.tarecruitment.model;

import java.util.ArrayList;
import java.util.List;

public class Applicant extends User {
    private List<String> skills;

    public Applicant() {
        this.skills = new ArrayList<>();
    }

    public Applicant(String id, String username, String password, String role, String fullName, String email,
                     List<String> skills) {
        super(id, username, password, role, fullName, email);
        this.skills = skills == null ? new ArrayList<>() : skills;
    }

    public List<String> getSkills() {
        if (skills == null) {
            skills = new ArrayList<>();
        }
        return skills;
    }

    public void setSkills(List<String> skills) {
        this.skills = skills == null ? new ArrayList<>() : skills;
    }
}
