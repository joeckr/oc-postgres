-- Create an application schema
CREATE SCHEMA IF NOT EXISTS app;

-- Set up custom UUID generation extension if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enum for user role testing
CREATE TYPE app.user_role AS ENUM ('admin', 'member', 'guest');

-- Create primary users table
CREATE TABLE IF NOT EXISTS app.users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    role app.user_role DEFAULT 'member',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Create secondary relational table
CREATE TABLE IF NOT EXISTS app.posts (
    id SERIAL PRIMARY KEY,
    author_id UUID NOT NULL REFERENCES app.users(id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    view_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Index for querying posts by author efficiently
CREATE INDEX IF NOT EXISTS idx_posts_author_id ON app.posts(author_id);

-- Insert mock seed data to verify mounting succeeded
INSERT INTO app.users (username, email, role) VALUES
    ('admin_user', 'admin@example.com', 'admin'),
    ('test_user', 'user@example.com', 'member')
ON CONFLICT (username) DO NOTHING;

INSERT INTO app.posts (author_id, title, content)
SELECT id, 'Welcome Post', 'This post verifies that schema mounting and seeding worked!'
FROM app.users WHERE username = 'admin_user';
