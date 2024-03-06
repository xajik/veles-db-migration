-- 31 12 2023: key_value_vector_index Up Migration

CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS key_value_vector (
    id SERIAL PRIMARY KEY,
    text TEXT, 
    metadata_ JSONB,
    -- IMPORTANT: update embedding vector size based on your embedding model! 
    embedding vector(768),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create a vector index
CREATE INDEX IF NOT EXISTS key_value_vector_idx ON key_value_vector USING ivfflat (embedding);

CREATE OR REPLACE TRIGGER update_key_value_vector_modtime
    BEFORE UPDATE ON key_value_vector
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();
