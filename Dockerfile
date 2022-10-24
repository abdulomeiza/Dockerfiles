FROM ubuntu
RUN echo "Run One Updated"
RUN echo "RUN TWO"
RUN echo "RUN Three"
CMD date
ENTRYPOINT [ "echo", "hello" ]


#git
FROM alpine/git as repo

MAINTAINER name info@acadalearning.com

WORKDIR /app
RUN git clone https://github.com/acadalearning/maven-web-app.git

#Maven
FROM maven:3.5-jdk-8-alpine as build
WORKDIR /app
COPY --from=repo /app/maven-web-app  /app 
RUN mvn install

#Tomcat
FROM tomcat:9.0.64-jre8-temurin-jammy
COPY --from=build /app/target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-app.war


