package ru.kortez.forum.repos;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import ru.kortez.forum.domain.Theme;
import ru.kortez.forum.domain.User;

public interface ThemeRepository extends CrudRepository<Theme, Long> {
    Page<Theme> findAll(Pageable pageable);

    Page<Theme> findAllByAuthor(User author, Pageable pageable);
}
