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


