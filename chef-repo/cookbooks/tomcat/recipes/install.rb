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


  