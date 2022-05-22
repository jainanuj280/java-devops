FROM openjdk
COPY . /src/java
WORKDIR /src/java
RUN ["javac", "Simple.java"]
ENTRYPOINT ["java", "Simple" ]
