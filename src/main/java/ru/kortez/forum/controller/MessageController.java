package ru.kortez.forum.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kortez.forum.domain.Message;
import ru.kortez.forum.domain.Theme;
import ru.kortez.forum.domain.User;
import ru.kortez.forum.service.MessageService;
import ru.kortez.forum.service.ThemeService;

import javax.validation.Valid;

@Controller
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private ThemeService themeService;

    //add message to theme
    @PostMapping("/addMessage")
    public String addMessage(@AuthenticationPrincipal User user,
                             @RequestParam("theme_id") Theme theme,
                             @Valid Message message,
                             BindingResult bindingResult,
                             @PageableDefault(sort = {"date"}, direction = Sort.Direction.ASC) Pageable pageable) {
        Page<Message> page = messageService.getAllMessagesTheme(theme, pageable);
        if (!bindingResult.hasErrors()) {
            messageService.addMessageToTheme(message, theme, user);
            themeService.updateDate(theme);
        }
        return "redirect:/theme/" + theme.getId()+"?page="+(page.getTotalPages()-1);
    }

    //delete message from theme
    @PostMapping("/delMessage")
    public String delMessage(@RequestParam("message_id") Message message,
                             @RequestParam("theme_id") Theme theme,
                             @RequestParam(value = "page") int pageNumber,
                             Model model) {

        messageService.deleteMessage(message);

        return "redirect:/theme/" + theme.getId() + "?page=" + pageNumber;
    }
}
