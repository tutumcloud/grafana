tutum-docker-grafana
====================

Grafana dashboard for Influx DB


Usage
-----
To create the image `tutum/grafana`, execute the following command on the tutum-docker-grafana folder:

    docker build -t tutum/grafana

To run the image and bind the port:

    docker run -d -p 80:80 tutum/grafana
    
The first time that you run your container, a new user `admin` will be created for HTTP basic auth with a random password. To get the password, check the logs of the container by running:

    docker logs <CONTAINER_ID>

You will see an output like the following:
```
 ========================================================================
 You can now connect to Grafana with the following credential:
 
     admin:ilNfrVn68r1N

 ========================================================================
```
In this case, `ilNfrVn68r1N` is the password allocated to the `admin` user.

You can now login you to Grafana in your browser: `http://127.0.0.1/`

Setting a specific password for the admin account
-------------------------------------------------
If you want to user a preset password instead of a random generated one, you can set the environment variable `HTTP_PASS` to you specific password when running the container:

    docker run -d -p 80:80 -e HTTP_PASS="mypass" tutum/grafana

You can now test it: `http://127.0.0.1/`

Configure your InfluxDB
-----------------------
`tutum/grafana` need to know the information of your InfluxDB for configuration. Please provide the following environment variables when running the containers:
```
INFLUXDB_1_PORT_8086_TCP_ADDR       Address of your InfluxDB (do not use prefix such as http://)
INFLUXDB_1_PORT_8086_TCP_PORT       Port number of your InfluxDB (8086 or the port mapping 8086)
INFLUXDB_DB_NAME                    Database name of your InfluxDB
INFLUXDB_USER=root                  Username of your InfluxDB
INFLUXDB_PASS=root                  Password of your InfluxDB
```
Here is an example:

    docker run -ti -p 80:80 -e INFLUXDB_1_PORT_8086_TCP_ADDR='influxdb-1-tifayuki.delta.tutum.io' -e INFLUXDB_1_PORT_8086_TCP_PORT='8086' -e INFLUXDB_DB_NAME=testdb -e INFLUXDB_USER=root -e INFLUXDB_PASS=root -e HTTP_PASS=admin tutum/grafana
    

Link to you InfluxDB
--------------------
You can also link `tutum/grafana` to your InfluxDB container directly by giving your InfluxDB an alais `INFLUXDB`. In this case, you don't need to specify `INFLUXDB_1_PORT_8086_TCP_ADDR` and `INFLUXDB_1_PORT_8086_TCP_PORT`.

Here is an example:

        docker run -ti -p 80:80 --link yourinflux:INFLUXDB -e INFLUXDB_DB_NAME=testdb -e INFLUXDB_USER=root -e INFLUXDB_PASS=root tutum/grafana
    
Done!

**by http://www.tutum.co**









