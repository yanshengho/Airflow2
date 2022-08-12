# https://www.youtube.com/watch?v=0UepvC9X4HY

delete_dangling() {
   sleep 90s  # Depends on the computer running it, but 90s is fine.
   docker rmi $(docker images -f "dangling=true" -q)
}

# Check existing folder before proceed
if [ -d "./airflow-docker" ];
then
    cp -f -r ./airflow-installer/requirements.txt ./airflow-docker/requirements.txt

    cd ./airflow-docker 
    docker compose stop
    docker compose up --build &
    delete_dangling
else
    # Else, abort..
    echo "No existing airflow-docker!\nAborting..."
fi