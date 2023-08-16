# Auto Instrumenting the RSVP Spring Boot with OpenTelemetry
OTEL with java instrumentation [official doc](https://opentelemetry.io/docs/instrumentation/java/getting-started/)

## Setup
- Download the *opentelemetry-javaagent jar* file from its [release repo](https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases).This jar file contains the agent and instrumentation libraries.
- Add `-javaagent:path/to/opentelemetry-javaagent.jar` and `-Dotel.service.name=your-service-name` launch the app with the following command
` java -javaagent:path/to/opentelemetry-javaagent.jar -Dotel.service.name=your-service-name -jar myapp.jar `
*OR*
- Set the following environment variables and run the app
```
export JAVA_TOOL_OPTIONS="-javaagent:path/to/opentelemetry-javaagent.jar"
export OTEL_SERVICE_NAME="your-service-name"
java -jar myapp.jar
```
## Configure the different Telemetry data agents
```
OTEL_TRACES_EXPORTER=zipkin or jaeger
OTEL_METRICS_EXPORTER=prometheus
OTEL_TRACES_EXPORTER=logging
```
Read more about [exporters and its configuration](https://github.com/open-telemetry/opentelemetry-java/tree/main/sdk-extensions/autoconfigure#exporters)

## To add Auto Instrumentation in Dockerfile
- Add the *opentelemetry-javaagent jar* in the Dockerfile. Check the Dockerfile [here](../Dockerfile)
- Create the docker image and push it to the container registry.

## Deploy OTEL-Collector and the app with exporters as docker containers
- Create a docker-compose file with the otel-collector, applications, telemetry data storage backends, and Grafana for analysis.
- Check the collector-config file [here](../collector-config-local.yaml) which will help in running OTEL collector with details about receivers and exporters
- The different exporters which have been used are:
    - To store logs: Loki is used
    - To store traces: Tempo is used
    - To store metrics: Prometheus is used
    - To visualize all these data: Grafana is used
- Find out the configuration files for each of these exporters in the [o11y-backend folder](../o11y-backend)
- Find the docker-compose file, which has all the containers details [here](../docker-compose.yaml)
    - Observe the different OTEL-related env variables set up in the `rsvp_spring` service
    ```
  environment:
      - MONGODB_HOST=mongodb
      - OTEL_METRICS_EXPORTER=otlp
      - OTEL_TRACES_EXPORTER=otlp
      - OTEL_LOGS_EXPORTER=otlp
      - OTEL_EXPORTER_OTLP_ENDPOINT=http://collector:5555
      - OTEL_TRACES_SAMPLER=always_on
      - OTEL_IMR_EXPORT_INTERVAL=5000
      - OTEL_METRIC_EXPORT_INTERVAL=5000
      - OTEL_RESOURCE_ATTRIBUTES=service.name=rsvp_spring,service.version=1.0,deployment.environment=development
   ``` 

### Steps to run them all
-  clone the repo with the **auto-instrument-otel** branch
```
https://github.com/oshi36/rsvpapp-springboot.git -b auto-instrument-otel
```
- Install docker and docker-compose if haven't
- Run the docker-compose file
```
docker-compose up -d
```
Wait for the containers to spin up
``` docker ps
   docker container ls
```
- Access the application at port 80 (http://localhost:80) and some entires in the app.
- Access the Grafana UI at port 30000 (http://localhost:30000)
- Click on explore in Grafana UI and analyze the data from different data sources individually.
