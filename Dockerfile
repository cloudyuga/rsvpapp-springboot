FROM maven
WORKDIR /workspace/app
COPY mvnw .
COPY pom.xml .
COPY src src
ENV LINK http://www.meetup.com/cloudyuga/
ENV TEXT1 CloudYuga
ENV TEXT2 Garage RSVP!
ENV LOGO https://raw.githubusercontent.com/cloudyuga/rsvpapp/master/static/cloudyuga.png
ENV COMPANY CloudYuga Technology Pvt. Ltd.

RUN mvn -DskipTests=true  package
EXPOSE 8080
WORKDIR /workspace/app/target
RUN mv *.war app.war
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar .
ENV JAVA_TOOL_OPTIONS "-javaagent:./opentelemetry-javaagent.jar"
CMD ["java","-jar","app.war"]

