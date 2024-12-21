-- liquibase formatted sql

--changeset Abhishek Malvadkar:2-create-users-after-update-trigger

DROP trigger IF EXISTS after_users_update_trigger;

CREATE TRIGGER after_users_update_trigger
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    INSERT INTO users_history (
        name,
        email,
        password,
        active,
        verification_token,
        last_login_time,
        delete_flag,
        created_on,
        created_by,
        updated_on,
        updated_by,
        role_id,
        user_id,
        history_time
    ) VALUES (
        old.name,
        old.email,
        old.password,
        old.active,
        old.verification_token,
        old.last_login_time,
        old.delete_flag,
        old.created_on,
        old.created_by,
        old.updated_on,
        old.updated_by,
        old.role_id,
        old.id,
        now()
    );
END;
