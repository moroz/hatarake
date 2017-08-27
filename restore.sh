# Assumes the database container is named 'db'

DOCKER_DB_NAME="$(docker-compose ps -q postgres)"
DB_HOSTNAME=injobs_dev
DB_USER=postgres
LOCAL_DUMP_PATH="../staging.sql"

docker-compose up -d postgres
docker exec -i "${DOCKER_DB_NAME}" psql -U "${DB_USER}" -d "${DB_HOSTNAME}" < "${LOCAL_DUMP_PATH}"
docker-compose stop postgres
