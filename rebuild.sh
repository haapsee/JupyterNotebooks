
docker compose down
docker volume rm jupyter_jupyterhome
docker compose up -d --build
sleep 3
docker compose exec jupyter jupyter lab password
docker compose restart
docker system prune

rm requirements.txt
docker compose exec jupyter pip freeze >> requirements.txt
