FROM openjdk:11
WORKDIR /home/app
COPY ./build/docker/main/layers/libs /home/app/libs
COPY ./build/docker/main/layers/classes /home/app/classes
COPY ./build/docker/main/layers/resources /home/app/resources
COPY ./build/docker/main/layers/application.jar /home/app/application.jar
EXPOSE 7314
ENTRYPOINT ["java", "-jar", "/home/app/application.jar"]