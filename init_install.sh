# Only proceed if secret.sh exist
if [ -f "./secret.sh" ]; 
then
    # sudo bash init_install.sh --prod
    # Alter .gitignore file (for Production only)
    if [ ! -z "$1" ] && [ ${1,,} == "--prod" ];
    then
        echo "Setup for Production"
        data=$'# Airflow 2\\\nsecret.sh\\\nairflow-docker\\/\\\nairflow-docker-old\\/'
        sed -i '141,$d' .gitignore
        sed -i -r "140s/# Airflow 2/$data/g" .gitignore
    else
        echo "Setup for Development"
    fi

    # Uninstalling existing Airflow
    bash uninstall.sh

    # Create airflow-docker folder
    mkdir -p -m a=rwx ./airflow-docker
    cp -f -r ./airflow-installer/* ./airflow-docker

    mkdir -p -m a=rwx ./airflow-docker/dags ./airflow-docker/logs ./airflow-docker/plugins

    # If existing airflow exists, transfer back the data into airflow-docker
    if [ -d "./airflow-docker-old" ];
    then
        mv -f -T ./airflow-docker-old/dags ./airflow-docker/dags 
        mv -f -T ./airflow-docker-old/plugins ./airflow-docker/plugins 
        rm -f -r ./airflow-docker-old
    fi

    cd ./airflow-docker
    echo "AIRFLOW_UID=$(id -u)" > .env
    bash ../secret.sh

    # Run the images
    docker compose up airflow-init
    docker compose up
else
    echo "secret.sh does not exists!\nAborting..."
fi