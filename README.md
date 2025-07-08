
# Docker compose 
    - Helps in project setup with multiple containers all at once, significantly reduceing the setup time, removes roadblocks to contribute.

# DOCKERIZING AN EXPRESS BACKEND TALKING TO A POSTGRES DATABASE

- initialize an empy node project
- add typescript, express, prisma

- Pull postgres image from registry
    >> docker pull Postgres
- Run postgres locally
    >>docker run \
    --name my_postgres_container \
    -e POSTGRES_USER=nihal \
    -e POSTGRES_PASSWORD=nihal123 \
    -e POSTGRES_DB=test1 \
    -p 5432:5432 \
    -d \
    postgres

    - Now PostgreSQL is successfully running on localhost:5432
        With:
        User: nihal
        Password: nihal123
        Database: test1
    - To connect to the db, add this to the .env 
    - DATABASE_URL = "postgresql://nihal:nihal123@localhost:5432/test1"


# If let say its an open source project with a bunch of contributers
# Following are the three different ways any new dev has to follow in order to setup the project locally and to contributes : 

1. Manual setup
    - make sure node installed, if not install nodejs locally
    - git clone
    - install dependencies
    - add prisma
        >> `npx prisma init`
    - get postgres connection string :
        - for postgres, either get neondb creds, or start via docker by : 
            >>docker run \
            --name my_postgres_container \
            -e POSTGRES_USER=nihal \
            -e POSTGRES_PASSWORD=nihal123 \
            -e POSTGRES_DB=test1 \
            -p 5432:5432 \
            -d \
            postgres
        - add DATABASE_URL="postgres://nihal:nihal123/test1" to .env
    - now
        - migrate db >> `npx prisma migrate dev`
        - generate db client >> `npx prisma generate`
    - `npm run build`
    - `npm run start`


2. Via Docker
    - clone the repo
    - make sure Docker is installed
    - create a custom network for both containers to communicate:
        docker network create express-postgres-network

    - start Postgres container:
        docker run --network express-postgres-network \
        --name my_postgres \
        -e POSTGRES_USER=nihal \
        -e POSTGRES_PASSWORD=nihal123 \
        -e POSTGRES_DB=test1 \
        -d -p 5432:5432 postgres

    - build the app image:
        docker build -t my_express_project .

    - run the app container:
        docker run --network express-postgres-network \
        -e DATABASE_URL="postgresql://nihal:nihal123@my_postgres:5432/test1" \
        -p 3000:3000 \
        --name my_express_container \
        my_express_project

    

3. Via Docker compose
    - make sure docker, docker-compose are installed
    - run `docker-compose up`


# About the -e, db credentials during setup
every contributor can:
- Run Postgres locally with their own preferred POSTGRES_USER, POSTGRES_PASSWORD, and POSTGRES_DB.
- Set their .env file accordingly based on what they used in the docker run command.
- Everything works as long as .env and docker run creds match.