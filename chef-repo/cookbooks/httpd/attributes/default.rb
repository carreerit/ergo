default['httpd']['MODJK_URL']='http://redrockdigimark.com/apachemirror/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.42-src.tar.gz'
default['httpd']['MODJK_TAR_FILE']="#{node['httpd']['MODJK_URL']}".split('/').last
default['httpd']['MODJK_TAR_LOC']="/opt/#{node['httpd']['MODJK_TAR_FILE']}"
default['httpd']['MODJK_TAR_DIR']="#{node['httpd']['MODJK_TAR_LOC']}".gsub('.tar.gz','')

default['httpd']['MODJK_CONF']='mod_jk.conf'
default['httpd']['MODJK_REM_CONF']="/etc/httpd/conf.d/#{node['httpd']['MODJK_CONF']}"
default['httpd']['TOMCAT_IP']='localhost'
default['httpd']['WORKERS_FILE']='workers.properties.erb'
default['httpd']['WORKERS_REM_FILE']="/etc/httpd/conf.d/workers.properties"