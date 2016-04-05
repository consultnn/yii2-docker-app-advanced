Docker-compose config for Yii 2 Advanced Project Template
===================================
Yii 2 docker is a configuration for easy deployment and development of Yii 2 Advanced Project Template.

REQUIREMENTS
------------

* [Docker](https://github.com/docker/docker/releases) >= v1.10.0
* [Docker Compose](https://github.com/docker/compose/releases) >= v1.6.0

INSTALLATION VIA COMPOSER
-------------------------
```
composer create-project --prefer-dist --no-install consultnn/yii2-docker-app-advanced app
```
FAST INSTALLATION
--------------------
```
git clone --depth=1 https://github.com/consultnn/yii2-docker-app-advanced.git app \
&& cd app \
&& rm -rf .git \
&& git clone --depth=1 git@github.com:yiisoft/yii2-app-advanced.git project \
&& rm -rf .git \
&& sudo chown -R $USER:$USER project
```

MANUAL INSTALLATION
---------------------
Clone this repository
```
git clone --depth=1 https://github.com/consultnn/yii2-docker-app-advanced.git app
```
Change directory
```
cd app
```
Remove git directory
```
rm -rf .git
```
Install Yii 2 Advanced Project Template via composer inside docker container
```
git clone --depth=1 git@github.com:yiisoft/yii2-app-advanced.git project
```
Remove git directory
```
rm -rf .git
```
Change project directory owner (default root, because process inside container run as root)
```
sudo chown -R $USER:$USER project
```

Add own [github token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) in ./docker/php/auth.json

DIRECTORY STRUCTURE
-------------------
```
docker                          contains docker configurations, build files and logs
    nginx                       nginx docker configuration
    php                         php docker configuration
    mongo                       mongodb docker configuration
project                         Yii 2 Advanced Project Template
docker-compose.yml              docker-compose configuration
production-compose.yml          docker-compose configuration for production env
common-compose.yml              common docker-compose configuration
```


USAGE
------
To execute commands inside docker container run
~~~
docker-compose run --rm {service} {command}
or, if application already running
docker exec {service} {command}
~~~
For example:
~~~
docker-compose run php composer install
docker exec run php /init
~~~

Start docker containers
~~~
docker-compose up -d
~~~
NOTE: git isn't installed in php container, so use `--prefer-dist` composer option
NOTE: default directory inside php container - "/project"

After start check http://127.0.0.1:8090
