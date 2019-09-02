create sequence hibernate_sequence start 1 increment 1;

create table message (
    id int8 not null,
    date timestamp,
    text varchar(2048) not null,
    user_id int8 not null,
    theme_id int8 not null,
    primary key (id)
);

create table theme (
    id int8 not null,
    date timestamp,
    description varchar(2048),
    title varchar(255) not null,
    user_id int8 not null,
    primary key (id)
);

create table user_role (
    user_id int8 not null,
    roles varchar(255)
);

create table usr (
    id int8 not null,
    active boolean not null,
    password varchar(255) not null,
    username varchar(255) not null,
    firstname varchar(255) not null,
    lastname varchar(255) not null,
    primary key (id)
);

alter table if exists message
    add constraint message_user_fk
    foreign key (user_id)
    references usr;

alter table if exists message
    add constraint message_theme_fk
    foreign key (theme_id)
    references theme;

alter table if exists theme
    add constraint theme_user_fk
    foreign key (user_id)
    references usr;

alter table if exists user_role
    add constraint user_role_user_fk
    foreign key (user_id)
    references usr;