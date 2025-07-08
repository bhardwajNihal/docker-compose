
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
2. Via Docker
3. Via Docker compose
