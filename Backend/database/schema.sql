BEGIN TRANSACTION;

CREATE TABLE users(
user_id SERIAL,
email varchar(50) NOT NULL UNIQUE,
password_hash varchar(200) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE profile(
profile_id SERIAL,
user_id INT NOT NULL,
display_name varchar(50) NOT NULL UNIQUE,
bio varchar(200),
profile_pic_url varchar(200),
background_music_url varchar(200),
custom_theme TEXT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PK_profiles PRIMARY KEY (profile_id),
CONSTRAINT FK_profile_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE posts(
post_id SERIAL, 
user_id INTEGER NOT NULL,
content TEXT NOT NULL,
media_url varchar(200),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PK_posts PRIMARY KEY (post_id),
CONSTRAINT FK_posts_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE friends(
friend_id SERIAL, 
requester_id INTEGER NOT NULL,
receiver_id INTEGER NOT NULL,
status varchar(50),
request_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
responded_at TIMESTAMP,
CONSTRAINT PK_friends PRIMARY KEY(friend_id),
CONSTRAINT FK_requester FOREIGN KEY (requester_id) REFERENCES users(user_id) ON DELETE CASCADE,
CONSTRAINT FK_receiver FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE comments(
comment_id SERIAL,
post_id INTEGER NOT NULL,
user_id INTEGER NOT NULL,
content varchar(300) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PK_comments PRIMARY KEY(comment_id),
CONSTRAINT FK_comment_post FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
CONSTRAINT FK_comment_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE likes(
like_id SERIAL,
post_id INTEGER NOT NULL,
user_id INTEGER NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT PK_likes PRIMARY KEY(like_id),
CONSTRAINT fk_like_post FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
CONSTRAINT fk_like_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE messages(
message_id SERIAL,
sender_id INTEGER NOT NULL,
receiver_id INTEGER NOT NULL,
subject VARCHAR(100),
body TEXT NOT NULL,
is_read BOOLEAN DEFAULT FALSE,
sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT pk_messages PRIMARY KEY (message_id),
CONSTRAINT fk_messages_sender FOREIGN KEY (sender_id) REFERENCES users(user_id),
CONSTRAINT fk_messages_receiver FOREIGN KEY (receiver_id) REFERENCES users(user_id)
);

COMMIT TRANSACTION;
