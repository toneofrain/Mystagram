CREATE TABLE member (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    profile_image_url VARCHAR(100) NULL,
    created_at TIMESTAMP NOT NULL,
    last_modified_at TIMESTAMP NOT NULL
);

CREATE TABLE follow (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    follower_id BIGINT NOT NULL,
    following_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    last_modified_at TIMESTAMP NOT NULL
);

CREATE TABLE post (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    writer_id BIGINT NOT NULL,
    image_url VARCHAR(100) NOT NULL,
    content VARCHAR(100) NULL,
    created_at TIMESTAMP NOT NULL,
    last_modified_at TIMESTAMP NOT NULL
);

CREATE TABLE comment (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    writer_id BIGINT NOT NULL,
    post_id BIGINT NULL,
    content VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    last_modified_at TIMESTAMP NOT NULL
);

CREATE TABLE reply (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    writer_id BIGINT NOT NULL,
    comment_id BIGINT NULL,
    content VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    last_modified_at TIMESTAMP NOT NULL
);

CREATE TABLE chat_room (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    last_modified_at TIMESTAMP NOT NULL
);

CREATE TABLE chat_user (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    member_id BIGINT NULL,
    chat_room_id BIGINT NOT NULL
);

CREATE TABLE chat_message (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    chat_user_id BIGINT NOT NULL,
    content VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    last_modified_at TIMESTAMP NOT NULL
);

ALTER TABLE follow
ADD CONSTRAINT fk_member_follower
FOREIGN KEY (follower_id)
REFERENCES member (id)
ON DELETE CASCADE;

ALTER TABLE follow
ADD CONSTRAINT fk_member_following
FOREIGN KEY (following_id)
REFERENCES member (id)
ON DELETE CASCADE;

ALTER TABLE post
ADD CONSTRAINT fk_member_post
FOREIGN KEY (writer_id)
REFERENCES member (id)
ON DELETE CASCADE;

ALTER TABLE comment
ADD CONSTRAINT fk_member_comment
FOREIGN KEY (writer_id)
REFERENCES member (id)
ON DELETE CASCADE;

ALTER TABLE comment
ADD CONSTRAINT fk_post_comment
FOREIGN KEY (post_id)
REFERENCES post (id)
ON DELETE SET NULL;

ALTER TABLE reply
ADD CONSTRAINT fk_member_reply
FOREIGN KEY (writer_id)
REFERENCES member (id)
ON DELETE CASCADE;

ALTER TABLE reply
ADD CONSTRAINT fk_comment_reply
FOREIGN KEY (comment_id)
REFERENCES comment (id)
ON DELETE SET NULL;

ALTER TABLE chat_user
ADD CONSTRAINT fk_member_chat_user
FOREIGN KEY (member_id)
REFERENCES member (id)
ON DELETE SET NULL;

ALTER TABLE chat_user
ADD CONSTRAINT fk_chat_room_chat_user
FOREIGN KEY (chat_room_id)
REFERENCES chat_room (id)
ON DELETE CASCADE;

ALTER TABLE chat_message
ADD CONSTRAINT fk_chat_user_chat_message
FOREIGN KEY (chat_user_id)
REFERENCES chat_user (id)
ON DELETE CASCADE;
