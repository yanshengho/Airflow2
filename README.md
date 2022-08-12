# Airflow2

## Getting Started
### Installation
This will perform ```Airflow 2``` installation and run it straight away.<br>
#### Pre-Requisite
Please ensure that you are in ```Linux``` environment, and has already install ```Docker```.<br><br>
If not, follow the following steps: (or refer to the Docker link: [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/))<br>
For a ```Clean Installation```, you can run the following codes:<br>
```
sudo apt-get remove docker docker-engine docker.io containerd runc

sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```
Now, let's begin the ```Docker Installation```
```
sudo apt-get update

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo docker run hello-world
```
After you have installed the ```Docker```, clone the ```Airflow 2``` repo and create a file as shown below.
```
git clone https://github.com/zaimzazali/Airflow2.git
cd Airflow2
touch secret.sh
```
Edit the ```secret.sh``` with the following content.<br>
You have to change the ```<...>``` values.
```
echo -e "AIRFLOW_WWW_USERNAME=<username>" >> .env
echo -e "AIRFLOW_WWW_PASSWORD=<password>" >> .env

echo -e "POSTGRES_USERNAME=<username>" >> .env
echo -e "POSTGRES_PASSWORD=<password>" >> .env
echo -e "POSTGRES_SERVER=postgres" >> .env
echo -e "POSTGRES_DB=airflow" >> .env

echo -e "SMTP_HOST=<smtp_server>" >> .env
echo -e "SMTP_PORT=587" >> .env
echo -e "SMTP_USER=<email_to_be_used>" >> .env
echo -e "SMTP_PASSWORD=<password>" >> .env
echo -e "SMTP_MAIL_FROM=<email_to_be_used>" >> .env
```
Finally, you can run..
```
sh init_install.sh
```
If you see the following respond, ```Airflow 2``` has go-live.<br>
Meaning, you can access the portal at ```http://localhost:8080/```
```
airflow-docker-airflow-webserver-1  | 127.0.0.1 - - [12/Jun/2022:09:47:23 +0000] "GET /health HTTP/1.1" 200 187 "-" "curl/7.74.0"
```
---
### Rebuild
This is where you want to rebuild the image because you have just added a few PIP packages to be installed in the ```requirements.txt```.
```
cd Airflow2
sh rebuild.sh
```
---
### Uninstall
This is where you want to uninstall the ```Airflow 2```.<br>
Note that the pipelines will be backed-up in the ```airflow-docker-old``` folder.
```
cd Airflow2
sh uninstall.sh
```
---
## FAQs
1) After I have installed the ```Airflow 2```, which ```requirements.txt``` should I edit? In the ```airflow-docker``` or ```airflow-installer```?<br> 
> Always edit in the ```airflow-installer``` folder.
2) If I messed up during the installation, what can I do?<br>
> Straight away ```CTRL + C```, and run the ```uninstall.sh``` script to clean up some images.
3) How the ```airflow-installer``` works?<br>
> The ```init_install.sh``` script will replicate the files in the folder into the ```airflow-docker```, and run on top of the docker file in the ```airflow-docker```.<br>
The files in the ```airflow-installer``` act as the ```true-source```.
