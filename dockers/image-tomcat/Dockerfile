FROM centos
RUN yum install wget java -y
RUN wget -qO- http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27.tar.gz | tar -xz
RUN rm -rf /apache-tomcat-8.5.27/webapps/*
COPY tomcat.sh /
RUN chmod 755 /tomcat.sh
CMD /tomcat.sh
