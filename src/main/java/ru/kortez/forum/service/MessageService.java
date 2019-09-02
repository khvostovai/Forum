package ru.kortez.forum.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import ru.kortez.forum.domain.Message;
import ru.kortez.forum.domain.Theme;
import ru.kortez.forum.domain.User;
import ru.kortez.forum.repos.MessageRepository;

import java.util.Date;
import java.util.List;

@Service
public class MessageService {

    @Autowired
    MessageRepository messageRepository;

    public void addMessageToTheme(Message message, Theme theme, User user){
        if (message != null && theme != null){
            message.setTheme(theme);
            message.setAuthor(user);
            message.setDate(new Date());
            messageRepository.save(message);
        }
    }

    public void deleteMessage(Message message){
        if(message != null){
            messageRepository.delete(message);
        }
    }

    public Page<Message> getAllMessagesTheme(Theme theme, Pageable pageable) {
        if(theme != null){
            return messageRepository.findAllByTheme(theme, pageable);
        }
        else
            return null;
    }

    public void deleteAllMessageFromTheme(Theme theme) {
        List<Message> themeMessages = messageRepository.findAllByTheme(theme);
        for (Message messsage : themeMessages) {
            messageRepository.delete(messsage);
        }
    }
}
