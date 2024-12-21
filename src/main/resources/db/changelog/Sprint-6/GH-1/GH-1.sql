-- liquibase formatted sql

--changeset Abhishek Malvadkar:1-create-users-table
create table users(
 id bigint  auto_increment primary key,
 name varchar(100) not null,
 email varchar(100) not null,
 password varchar(255) not null,
 salt varchar(255) not null,
 active bit(1) not null default 0,
 verification_token varchar(255) not null,
 last_login_time datetime null,
 delete_flag bit(1) not null default 0,
 created_on datetime not null,
 created_by bigint not null,
 updated_on datetime not null,
 updated_by bigint not null,
 role_id bigint not null
 );

--changeset Abhishek Malvadkar:2-create-users_history-table
create table users_history(
 id bigint  auto_increment primary key,
 name varchar(100) not null,
 email varchar(100) not null,
 password varchar(255) not null,
 salt varchar(255) not null,
 active bit(1) not null default 0,
 verification_token varchar(255) not null,
 last_login_time datetime null,
 delete_flag bit(1) not null default 0,
 created_on datetime not null,
 created_by bigint not null,
 updated_on datetime not null,
 updated_by bigint not null,
 role_id bigint not null,
 user_id bigint not null,
 history_time datetime not null
 );

--changeset Abhishek Malvadkar:3-create-role-table
 create table role(
 id bigint  auto_increment primary key,
 name varchar(100) not null,
 description varchar(200) null
 );

 --changeset Abhishek Malvadkar:4-create-foreign-key-constraints-for-users-table
alter table users add constraint fk_users_created_by
foreign key(created_by) references users(id);

alter table users add constraint fk_users_updated_by
foreign key(updated_by) references users(id);

alter table users add constraint fk_users_role_id foreign key(role_id)
references role(id);


--changeset Abhishek Malvadkar:5-create-foreign-key-constraints-for-users_history-table
alter table users_history add constraint fk_users_history_created_by
foreign key(created_by) references users(id);

alter table users_history add constraint fk_users_history_updated_by
foreign key(updated_by) references users(id);

alter table users_history add constraint fk_users_history_role_id foreign key(role_id)
references role(id);

alter table users_history add constraint fk_users_history_user_id foreign key(user_id)
references users(id)


--changeset Abhishek Malvadkar:6-create-some-roles
INSERT INTO `role` (id, `name`, `description`) VALUES
(1, 'SYSTEM', 'System'),
(2, 'ADMIN', 'Admin'),
(3, 'CUSTOMER', 'Customer');

--changeset Abhishek Malvadkar:7-drop-salt-column
ALTER TABLE `users` DROP COLUMN `salt`;
ALTER TABLE `users_history` DROP COLUMN `salt`;

--changeset Abhishek Malvadkar:8-make-verification-token-null
ALTER TABLE `users`
CHANGE COLUMN `verification_token` `verification_token` VARCHAR(255) NULL ;


--changeset Abhishek Malvadkar:9-create-app-config-table
CREATE TABLE app_config (
    id bigint auto_increment primary key,
    `key` VARCHAR(255) NOT NULL UNIQUE,
    `value` VARCHAR(1000) null,
    `category` VARCHAR(100) not null,
    `type` VARCHAR(200) not null,
    delete_flag BIT(1) NOT NULL DEFAULT 0,
    created_on DATETIME NOT NULL,
    created_by BIGINT  not null,
    updated_on DATETIME NOT NULL,
    updated_by BIGINT  not null
);


--changeset Abhishek Malvadkar:10-insert-app-configs-for-general-category
INSERT INTO app_config (`key`, `value`, `category`, `type`, created_on,updated_on,created_by, updated_by)
VALUES
('siteLogo', 'url', 'GENERAL','text', UTC_TIMESTAMP(), UTC_TIMESTAMP() , 1, 1),
('siteTagLine', 'Helps To Manage Tasks', 'GENERAL', 'text' ,UTC_TIMESTAMP(),UTC_TIMESTAMP() , 1, 1),
('productVersion', '1.0', 'GENERAL', 'decimal', UTC_TIMESTAMP(),UTC_TIMESTAMP() , 1, 1),
('preMaintenanceMsg', null, 'GENERAL', 'text', UTC_TIMESTAMP(),  UTC_TIMESTAMP() , 1, 1),
('maintenanceMsg', null, 'GENERAL', 'text', UTC_TIMESTAMP(),  UTC_TIMESTAMP() , 1, 1),
('maintenanceFrom', null, 'GENERAL', 'datetime', UTC_TIMESTAMP(),  UTC_TIMESTAMP() , 1, 1),
('maintenanceTo', null, 'GENERAL', 'datetime', UTC_TIMESTAMP(),UTC_TIMESTAMP() , 1, 1);