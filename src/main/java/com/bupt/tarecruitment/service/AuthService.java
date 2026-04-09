package com.bupt.tarecruitment.service;

import com.bupt.tarecruitment.model.User;
import com.bupt.tarecruitment.repository.UserRepository;

import javax.servlet.ServletContext;

public class AuthService {
    private final UserRepository userRepository;

    public AuthService(ServletContext servletContext) {
        this.userRepository = new UserRepository(servletContext);
    }

    public User login(String username, String password) {
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            return null;
        }
        return userRepository.findByUsernameAndPassword(username.trim(), password.trim());
    }
}
