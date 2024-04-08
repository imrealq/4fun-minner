# replace name worker
set -e

if [ -f ".env" ]; then
    source .env
else
    echo "File .env not found! Default .env.template"
    source .env.template
fi

if [ ! -d "./xmrig" ]; then
    git clone --depth 1 https://github.com/xmrig/xmrig.git xmrig
fi

if [ ! -z "$(docker images -q myimage:mytag 2> /dev/null)" ]; then
  docker build . -t xmrig:local
fi

docker run -dt --name ${WORKER_NAME} \
    --cpus 1 \
    --memory 2.5g \
    -e "WORKER_NAME=${WORKER_NAME}" \
    xmrig:local &&
docker exec -idt ${WORKER_NAME} bash -c "./xmrig -c config.json | tee -a /var/log/minner.log"

echo "${WORKER_NAME} were started"