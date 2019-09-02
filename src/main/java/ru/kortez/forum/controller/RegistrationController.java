package ru.kortez.forum.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kortez.forum.domain.User;
import ru.kortez.forum.service.UserService;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration(Model model){
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@RequestParam("password2") String passwordConfirm,
                          @Valid User user,
                          BindingResult bindingResult,
                          Model model){
        String validationResult = ControllerUtils.validatePassword(user.getPassword());
        boolean isPasswordVerify = validationResult.equals("valid");
        if(!isPasswordVerify)
            model.addAttribute("passwordError", validationResult);

        boolean isConfirmEmpty = passwordConfirm.isEmpty();
        if(isConfirmEmpty)
            model.addAttribute("password2Error","Password confirmation can't be empty");

        if(user.getPassword() != null && !user.getPassword().equals(passwordConfirm) ){
            model.addAttribute("passwordcleanError", "Passwords are different");
        }

        boolean isUserExist = userService.addUser(user);
        if(!isUserExist){
            model.addAttribute("usernameError", "user exist");
        }

        if(bindingResult.hasErrors() || isConfirmEmpty || !isPasswordVerify || isUserExist){
            Map<String, String> errors = ControllerUtils.getErrors(bindingResult);
            model.mergeAttributes(errors);
            return "/registration";
        }


        else {
            return "redirect:/login";
        }
    }
}
