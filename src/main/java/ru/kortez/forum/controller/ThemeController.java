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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kortez.forum.domain.Theme;
import ru.kortez.forum.domain.User;
import ru.kortez.forum.service.ThemeService;

import javax.validation.Valid;

@Controller
public class ThemeController {
    @Autowired
    private ThemeService themeService;


    //show list of themes
    @GetMapping("/themes")
    String themesList(Model model,
                      @PageableDefault(sort = {"date"}, direction = Sort.Direction.DESC) Pageable pageable) {
        Page<Theme> page = themeService.getAllThemes(pageable);
        model.addAttribute("page", page);
        model.addAttribute("url", "/themes");
        return "themes";
    }

    //show list of user themes
    @GetMapping("/user-themes/{user}")
    String getUsersThemes(@AuthenticationPrincipal User currentUser,
                          @PathVariable User user,
                          Model model,
                          @PageableDefault(sort = {"date"}, direction = Sort.Direction.DESC) Pageable pageable) {
        Page<Theme> page = themeService.getUserThemes(user, pageable);
        model.addAttribute("page", page);
        model.addAttribute("url", "/user-themes/" + user.getId());
        return "themes";
    }

    //add new theme
    @PostMapping("/themes")
    String addTheme(@AuthenticationPrincipal User user,
                    @Valid Theme theme,
                    BindingResult bindingResult) {
        if (!bindingResult.hasErrors()) {
            themeService.addNewTheme(theme, user);
            return "redirect:/theme/"+ theme.getId();
        }
        else
            return "/themes";
    }

    //delete theme
    @PostMapping("/delTheme")
    String deleteTheme(@RequestParam("theme_id") Theme theme,
                       @RequestParam("page") int pageNumber) {
        themeService.deleteTheme(theme);
        return "redirect:/themes?page="+ pageNumber;
    }

    //show messages which belong theme
    @GetMapping("/theme/{theme}")
    String showTheme(@PathVariable Theme theme,
                     Model model,
                     @PageableDefault() Pageable pageable) {
        Page page = themeService.getGetAllMessagesFromTheme(theme, pageable);
        model.addAttribute("page", page);
        model.addAttribute("url", "/theme/" + theme.getId());
        model.addAttribute("theme_id", theme.getId());
        model.addAttribute("title", theme.getTitle());
        return "messages";
    }
}
