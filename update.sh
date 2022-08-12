# stash any changes detected in the production server

cd ./airflow-docker 
docker compose stop
cd ../

git stash
git pull
git submodule update --recursive
git pull --recurse-submodules
git stash pop

cd airflow-docker/plugins/Utils_Python/
git stash
git stash clear
git switch main
git pull
git submodule update --recursive
git pull --recurse-submodules
cd ../../..

cd ./airflow-docker 
docker compose up -d
cd ../