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

docker run \
    --cpus 1 \
    --memory 2.5g \
    -d --name ${WORKER_NAME} xmrig:local

echo "${WORKER_NAME} were started"