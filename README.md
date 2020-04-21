# rsvpapp-springboot
RSVP applicaiton with springboot
# Quick start
 ## Setting up in local system
 1. Clone the project or download the project into local system
 2. Download and install jdk(java 8 is recommended) , maven and mongodb
    - For java installtion [click here](https://data-flair.training/blogs/install-java/)
    - maven installtaion on ubuntu
      - ```
        $sudo apt update
        $sudo apt install maven
        $mvn -version
        ```
       - for windows [click here](https://howtodoinjava.com/maven/how-to-install-maven-on-windows/)
    - You can configure mongodb with docker 
      - open terminal and run mongo container 
        ```
        docker container run -d -p 27017:27017 --name mongodb mongo:3.3
        ```
      - for mongodb installation on local machine [click here](https://docs.mongodb.com/manual/administration/install-community/)
    
    
 3. Open mongodb server
 4. Set environment variables
    ```
    LINK: http://www.meetup.com/cloudyuga/
    TEXT1: CloudYuga 
    TEXT2: Garage RSVP!
    LOGO: https://raw.githubusercontent.com/cloudyuga/rsvpapp/master/static/cloudyuga.png
    COMPANY: CloudYuga Technology Pvt. Ltd.
    ```
 5. Navigate terminal inside to the project
 6. Make a ".war" file with command
    `mvn package` to skip test cases use `mvn -DskipTests=true  package`
 7. Now goto target folder and open ".war" file or give command
    `java -jar rsvp-0.0.1-SNAPSHOT.war`
 8. By default the application will look http://localhost:27017 for MongoDb connection. 
 9. Embeded Tomcat server will run on http://localhost:8080
## Building Docker Image
 1. Make sure that docker is installed on your machine
 2. Navigate terminal inside to the Dockerfile's folder and give command
   `docker image build -t <--image name--> .`
 
 ## Start application with docker image
 1. We need to have mongo image before runnig our container
 2. Get the mongo image with command
   `docker pull mongo:3.3`
 3. Now we make sure that both mongo container and our image container should run on the same network
 4. Create network
   `docker network create <--mynetworkname-->`
 5. Run mongo container 
   ```
   docker container run -d --network=<--mynetworkname--> -p 27017:27017 --name mongodb mongo:3.3
   ```
 6. Now run our container 
   ```
   docker container run -d --network=<--mynetworkname--> -p 8080:8080 --mycontainer <--image name-->
   ```
 7. Application is running on http://localhost:8080 or http://yourdockeripaddress:8080
 
## Docker-compose
1. Direct lauch the app with docker compose
2. Navigate the terminal inside to the folder where docker-compose.yml file is located.and give command
  ```
  docker-compose up
  ``` 
3. It will download mongo and our image and run on http://localhost:8080
