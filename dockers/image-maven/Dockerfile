FROM centos
RUN yum install git maven -y 
COPY env.sh /env.sh 
RUN chmod +x /env.sh 
#### CMD is used to run the default command of container
CMD /env.sh
