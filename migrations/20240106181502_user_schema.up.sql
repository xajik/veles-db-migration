-- 06 01 2024: user_schema Up Migration

CREATE SCHEMA IF NOT EXISTS users;

CREATE TABLE IF NOT EXISTS users.user(
    id              BIGSERIAL       PRIMARY KEY,
	user_name		VARCHAR(60),
    password_hash   VARCHAR(254),
    email		    VARCHAR(254),  -- RFC 5321,
    email_verified  BOOLEAN         NOT NULL DEFAULT FALSE,
	unique_key      uuid            NOT NULL UNIQUE DEFAULT    gen_random_uuid(),
    created_at		TIMESTAMP	    NOT NULL DEFAULT now(),
	updated_at		TIMESTAMP	    NOT NULL DEFAULT now()
);

-- Add a partial unique index on the email for verified email only
CREATE UNIQUE INDEX IF NOT EXISTS idx_unique_verified_phone
    ON users.user (email)
    WHERE email_verified = TRUE;

CREATE OR REPLACE TRIGGER update_users_user_update_time
    BEFORE UPDATE ON users.user
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();