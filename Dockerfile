# Set the base image to Ubuntu
FROM ubuntu


# Update the repository sources list
RUN apt-get update

################## BEGIN INSTALLATION ######################
# Install opejdk
RUN apt-get install -y default-jdk

# install git and maven
RUN  apt-get install -y  git maven


# Create the default data directory
RUN mkdir -p /data/

# switch to new directory

WORKDIR /data

# perform git clone
RUN git clone https://github.com/vikramsardeshpande/persistentwebapp.git

# switch to persistentwebapp directory
WORKDIR /data/persistentwebapp/persistentwebapp

# use maven to package
RUN mvn package


# install tomcat7
RUN apt-get install -y tomcat7

# switch to cloudenabledwebapp directory
WORKDIR /data/persistentwebapp/persistentwebapp/target/

# copy war file
#ADD PersistentWebApp.war /var/lib/tomcat7/webapps/
RUN cp /data/persistentwebapp/persistentwebapp/target/PersistentWebApp.war /var/lib/tomcat7/webapps/



# Expose the default port
EXPOSE 8080

# Default port to execute the entrypoint
CMD ["--port 8080"]

# Set default container command
#ENTRYPOINT /bin/bash
ENV CATALINA_BASE /var/lib/tomcat7
ENTRYPOINT [ "/usr/share/tomcat7/bin/catalina.sh", "run" ]
# Start Tomcat, after starting Tomcat the container will stop. So use a 'trick' to keep it running.
#CMD service tomcat7 start && tail -f /var/lib/tomcat7/logs/catalina.out
#CMD ["/etc/init.d/tomcat7 start"]


##################### INSTALLATION END #####################