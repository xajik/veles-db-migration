-- 31 12 2023: key_value Up Migration

CREATE TABLE IF NOT EXISTS key_value_store (
    id SERIAL PRIMARY KEY,
    key VARCHAR(100) UNIQUE NOT NULL,
    value JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to update 'updated_at' timestamp on row update
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = CURRENT_TIMESTAMP;
   RETURN NEW;   
END;
$$ language 'plpgsql';

CREATE OR REPLACE TRIGGER update_key_value_store_update_time
    BEFORE UPDATE ON key_value_store
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_column();



