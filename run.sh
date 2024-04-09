# replace name worker
set -e

if [ -f ".env" ]; then
    source .env
else
    echo "File .env not found! Default .env.template"
    source .env.template
fi


if [ ! -z "docker image ls -q xmrig:local 2> /dev/null" ]; then
  docker build . -t xmrig:local
fi

docker run \
    --restart=always \
    --cpus 2 \
    --memory 3g \
    -d --name ${CONTAINER_NAME} xmrig:local

echo "${CONTAINER_NAME} were started"