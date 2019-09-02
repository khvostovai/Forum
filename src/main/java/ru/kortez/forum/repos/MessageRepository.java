package ru.kortez.forum.repos;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import ru.kortez.forum.domain.Message;
import ru.kortez.forum.domain.Theme;

import java.util.List;

public interface MessageRepository extends CrudRepository<Message, Long> {
    Page<Message> findAllByTheme(Theme theme, Pageable pageable);

    List<Message> findAllByTheme(Theme theme);
}
