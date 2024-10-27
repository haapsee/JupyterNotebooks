docker compose down
docker volume rm jupyter_jupyterhome
docker compose up -d --build
sleep 3
docker system prune -af
rm requirements.txt
docker compose exec jupyter pip freeze >> requirements.txt
