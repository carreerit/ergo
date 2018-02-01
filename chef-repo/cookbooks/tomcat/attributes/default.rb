default['tomcat']['URL']='http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27.tar.gz'
default['tomcat']['TAR_FILE_NAME']="#{node['tomcat']['URL']}".split('/').last
default['tomcat']['TAR_FILE_LOC']="/opt/#{node['tomcat']['TAR_FILE_NAME']}"
default['tomcat']['TAR_DIR']="#{node['tomcat']['TAR_FILE_LOC']}".gsub('.tar.gz','')
default['tomcat']['WAR_URL']='https://github.com/carreerit/cogito/raw/master/appstack/student.war'
default['tomcat']['MYSQL_LIB_URL']='https://github.com/carreerit/cogito/raw/master/appstack/mysql-connector-java-5.1.40.jar'
default['tomcat']['DBHOST']='localhost'

