# Check existing folder before proceed
if [ -d "./airflow-docker" ];
then
    cd ./airflow-docker
    docker compose down --volumes --rmi all

    cd ..
    mkdir -p -m a=rwx ./airflow-docker-old/dags ./airflow-docker-old/plugins
    mv -f -T ./airflow-docker/dags ./airflow-docker-old/dags
    mv -f -T ./airflow-docker/plugins ./airflow-docker-old/plugins

    rm -f -r ./airflow-docker
else
    # Else, abort..
    echo "No existing airflow-docker!\nAborting..."
fi

docker images