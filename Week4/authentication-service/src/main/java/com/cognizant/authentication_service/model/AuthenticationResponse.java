package com.cognizant.authentication_service.controller;

import com.cognizant.authentication_service.model.AuthenticationResponse;
import com.cognizant.authentication_service.util.JwtUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthenticationController {

    @GetMapping("/authenticate")

    public AuthenticationResponse authenticate(){

        String token = JwtUtil.generateToken("user");

        return new AuthenticationResponse(token);

    }

}