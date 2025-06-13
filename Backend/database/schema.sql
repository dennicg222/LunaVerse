BEGIN TRANSACTION;

CREATE TABLE users(
user_id SERIAL,
email varchar(50) NOT NULL,
password_hash varchar(200) NOT NULL,
created_at time, 
updated_at time,
CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE PROFILE(
user_id SERIAL,
display_name varchar(50) NOT NULL UNIQUE,
bio varchar(200),
profile_pic_url varchar(200),
background_music_url varchar(200),
custom_css varchar(200),
created_at DEFAULT TIME,
updated_at DEFAULT TIME,
CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE POSTS(
user_id SERIAL, 
content,
media_url varchar(200),
created_at DEFAULT TIME,
updated_at DEFAULT TIME,
CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE FRIENDS(
user_id SERIAL, 
requester_id SERIAL,
receiver_id SERIAL,
status varchar(50),
request_at DEFAULT TIME,
responded_at DEFAULT TIME,
CONSTRAINT PK_user PRIMARY KEY(user_id)
);

CREATE TABLE COMMENTS(
id SERIAL,
post_id SERIAL,
user_id SERIAL,
content varchar(75),
created_at DEFAULT TIME,
CONSTRAINT PK_post PRIMARY KEY(id)
);

CREATE TABLE LIKES(
id SERIAL,
post_id SERIAL,
user_id SERIAL,
created_at DEFAULT TIME,
CONSTRAINT PK_post PRIMARY KEY(id)
);

COMMIT TRANSACTION;
