git submodule update --init --recursive

docker run --rm -v "$PWD:/usr/src/app" -w /usr/src/app node:14 bash -c "
    pushd deps/chat-backend && npm install && npm run build && popd &&
    pushd deps/chat-frontend && npm install && npm run build && popd
"

mkdir -p app
cp -r deps/chat-backend/dist/* app/.
cp deps/chat-backend/package*.json app/.
cp .env.example app/.env
cp docker-compose.yml app/.
cp Dockerfile app/.
cp nginx.conf app/.

# mkdir -p app/dhparam
# sudo openssl dhparam -out app/dhparam/dhparam-2048.pem 2048

mkdir -p app/client
cp -r deps/chat-frontend/dist/chat/* app/client/.