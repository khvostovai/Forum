package ru.kortez.forum.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.kortez.forum.domain.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
