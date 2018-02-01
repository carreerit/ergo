remote_file "#{node['tomcat']['TAR_FILE_LOC']}" do
    source "#{node['tomcat']['URL']}"
    action :create
end

if not File.directory?("#{node['tomcat']['TAR_DIR']}") 
    execute 'Untar tomcat tar file' do
        command "tar xf #{node['tomcat']['TAR_FILE_NAME']}"
        cwd '/opt'
        action :run
    end
end

Dir["#{node['tomcat']['TAR_DIR']}/webapps/*"].each do |foo|
    if File.directory?("#{foo}")
        directory "#{foo}" do
            action :delete
            recursive true
        end
    end 
    if File.file?("#{foo}") 
        file "#{foo}" do
            action :delete
        end
    end
end

remote_file "#{node['tomcat']['TAR_DIR']}/webapps/student.war" do
    source "#{node['tomcat']['WAR_URL']}"
    action :create
end

remote_file "#{node['tomcat']['TAR_DIR']}/lib/mysql-connector-java-5.1.40.jar" do
    source "#{node['tomcat']['MYSQL_LIB_URL']}"
    action :create
end

template "#{node['tomcat']['TAR_DIR']}/conf/context.xml" do
  source 'context.xml.erb'
  action :create
end

template "#{node['tomcat']['TAR_DIR']}/tomcatctl.sh" do
    source 'tomcatctl.sh.erb'
    mode '0755'
    action :create
  end

execute 'Start tomcat' do
  command "#{node['tomcat']['TAR_DIR']}/tomcatctl.sh restart"
  action :run
end


