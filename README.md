# Veles DB Migration

![alt text](img/Veles.png)

Use [Dockerfile](Dockerfile) for development `docker-compose` and [Dockerfile.prd](Dockerfile.prd) for release.

## Migratoins
Provided 2 ways to do migrations with PSQL and golang-migrate. 

### Golang-migrate

We use [golang-migrate](https://github.com/golang-migrate/migrate) to do migration since it will track versioning.

* `migrate -path ./migrations -database $DATABASE_URL up`
* `migrate -path ./migrations -database $DATABASE_URL down`

### Migration via PSQL scripts

Required to install `postgresql-client` It will not provide migration versioning tracking, only appying scripts to DB.

* Execute migration: 
    * using PSQL:
    * ```./scrips/wait-for-db.sh && ./scrips/run-migrations-up.sh```
* Migrate down in case of error: 
    * using PSQL:
    * ```./scrips//run-migrations-down.sh```

## Docker

Can test manually via attaching to container:

* Find container: 
    * ```docker ps``` // find ID
* Attach shell: 
    * ```docker exec -it <container_name_or_id> /bin/bash```

## AWS ECR Docker image 

Example with registry name `veles-ecr-repository` 

```

aws ecr get-login-password --region us-east-1 --profile `aws_profile` | docker login --username AWS --password-stdin 00000000000.dkr.ecr.us-east-1.amazonaws.com
docker build --platform=linux/amd64 -t veles-ecr-repository -f Dockerfile.prd .
docker tag veles-ecr-repository:latest 00000000000.dkr.ecr.us-east-1.amazonaws.com/veles-ecr-repository
docker push 00000000000.dkr.ecr.us-east-1.amazonaws.com/veles-ecr-repository

```

## Note

<b>Update embedding vector size based on your embedding model:</b> [Embeddings](migrations/20231231123240_key_value_vector_index.up.sql)