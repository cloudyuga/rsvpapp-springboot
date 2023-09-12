FROM maven:3.8.6-openjdk-8-slim AS build
RUN mkdir /project
COPY . /project
WORKDIR /project
RUN mvn clean package -DskipTests


FROM eclipse-temurin:8-jdk-jammy
RUN mkdir /app
RUN addgroup --system javauser && adduser --ingroup javauser --disabled-password javauser
COPY --from=build /project/target/*.war /app/app.war
WORKDIR /app
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar /app
RUN chown -R javauser:javauser /app
USER javauser
ENV LINK http://www.meetup.com/cloudyuga/
ENV TEXT1 CloudYuga
ENV TEXT2 Garage RSVP!
ENV LOGO https://raw.githubusercontent.com/cloudyuga/rsvpapp/master/static/cloudyuga.png
ENV COMPANY CloudYuga Technology Pvt. Ltd.
ENV JAVA_TOOL_OPTIONS "-javaagent:./opentelemetry-javaagent.jar"

EXPOSE 8080
CMD ["java","-jar","app.war"]
