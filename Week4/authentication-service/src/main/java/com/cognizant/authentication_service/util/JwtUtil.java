package com.cognizant.authentication_service.util;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Date;

public class JwtUtil {

    private static final String SECRET =
            "mysecretkeymysecretkeymysecretkey";

    public static String generateToken(String username){

        return Jwts.builder()

                .setSubject(username)

                .setIssuedAt(new Date())

                .setExpiration(
                        new Date(System.currentTimeMillis()+600000)
                )

                .signWith(
                        SignatureAlgorithm.HS256,
                        SECRET.getBytes()
                )

                .compact();
    }

}