FROM openjdk:8
WORKDIR /workspace/app

ENV LINK http://www.meetup.com/cloudyuga/
ENV TEXT1 CloudYuga
ENV TEXT2 Garage RSVP!
ENV LOGO https://raw.githubusercontent.com/cloudyuga/rsvpapp/master/static/cloudyuga.png
ENV COMPANY CloudYuga Technology Pvt. Ltd.

EXPOSE 8080
COPY /target/*.war app.war
CMD ["java","-jar","app.war"]

