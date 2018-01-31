default['tomcat']['URL']='http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.27/bin/apache-tomcat-8.5.27.tar.gz'
default['tomcat']['TAR_FILE_NAME']="#{node['tomcat']['URL']}".split('/').last
default['tomcat']['TAR_FILE_LOC']="/opt/#{node['tomcat']['TAR_FILE_NAME']}"
default['tomcat']['TAR_DIR']="#{node['tomcat']['TAR_FILE_LOC']}".gsub('.tar.gz','')

