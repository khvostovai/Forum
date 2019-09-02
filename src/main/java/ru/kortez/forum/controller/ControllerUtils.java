package ru.kortez.forum.controller;

import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collector;
import java.util.stream.Collectors;

class ControllerUtils {
    static Map<String, String> getErrors(BindingResult bindingResult) {
        Collector<FieldError, ?, Map<String, String>> collector = Collectors.toMap(
                fieldError -> fieldError.getField() + "Error",
                FieldError::getDefaultMessage
        );
        return bindingResult.getFieldErrors().stream().collect(collector);
    }

    static String validatePassword(String password){
        Pattern digit = Pattern.compile("[0-9]");
        Pattern upper = Pattern.compile("[A-Z]");
        Pattern lower = Pattern.compile("[a-z]");
        Pattern symbol = Pattern.compile("[!@#$%]");

        if(password.length() < 8)
            return "Password's lenght must be grate 8 characters";
        if(!digit.matcher(password).find())
            return "Password's must contain at least one digit";
        if(!lower.matcher(password).find())
            return "Password's must contain at least one lowercase letter";
        if(!upper.matcher(password).find())
            return  "Password's must contain at least one capital letter";
        if(!symbol.matcher(password).find())
            return "Password's must contain at least one characters (!@#$%)";
        return "valid";
    }
}
