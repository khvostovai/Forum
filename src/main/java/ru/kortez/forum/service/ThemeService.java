package ru.kortez.forum.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import ru.kortez.forum.domain.Message;
import ru.kortez.forum.domain.Theme;
import ru.kortez.forum.domain.User;
import ru.kortez.forum.repos.ThemeRepository;

import java.util.Date;

@Service
public class ThemeService {

    @Autowired
    private ThemeRepository themeRepository;

    @Autowired
    private MessageService messageService;

    public void addNewTheme(Theme theme, User user) {
        if(theme != null && user!=null) {
            theme.setAuthor(user);
            theme.setDate(new Date());
            themeRepository.save(theme);
        }
    }

    public Page<Theme> getAllThemes(Pageable pageable) {
        return themeRepository.findAll(pageable);
    }

    public void deleteTheme(Theme theme) {
        if(theme != null)
        {
            messageService.deleteAllMessageFromTheme(theme);
            themeRepository.delete(theme);
        }
    }

    public Page<Message> getGetAllMessagesFromTheme(Theme theme, Pageable pageable) {
        if (theme != null) {
            return messageService.getAllMessagesTheme(theme, pageable);
        }
        else
            return null;
    }

    public void updateDate(Theme theme) {
        theme.setDate(new Date());
        themeRepository.save(theme);
    }

    public Page<Theme> getUserThemes(User user, Pageable pageable) {
        if (user != null)
            return themeRepository.findAllByAuthor(user, pageable);
        else return null;
    }
}
