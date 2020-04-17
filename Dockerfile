FROM maven as build
WORKDIR /workspace/app

COPY mvnw .
COPY pom.xml .
COPY src src
RUN mvn clean package


FROM openjdk:12-jdk-alpine
ARG TARGET=/workspace/app/target
COPY --from=build ${TARGET} /app/lib/target
EXPOSE 8080
ENV LINK http://www.meetup.com/cloudyuga/
ENV TEXT1 CloudYuga
ENV TEXT2 Garage RSVP!
ENV LOGO https://raw.githubusercontent.com/cloudyuga/rsvpapp/master/static/cloudyuga.png
ENV COMPANY CloudYuga Technology Pvt. Ltd.
WORKDIR /app/lib/target
RUN mv *.war app.war
CMD ["java","-jar","app.war"]

