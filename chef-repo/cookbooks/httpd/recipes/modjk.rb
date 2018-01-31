
remote_file "#{node['httpd']['MODJK_TAR_LOC']}" do
  source "#{node['httpd']['MODJK_URL']}"
  action :create
end

if not File.directory?("#{node['httpd']['MODJK_TAR_DIR']}") 
    execute 'Untar MODJK tar file' do
        command "tar xf #{node['httpd']['MODJK_TAR_FILE']}"
        cwd '/opt'
        action :run
    end
end

package 'gcc'

if not File.exist?('/etc/httpd/modules/mod_jk.so')
    execute 'Compiling MODJK' do
        command './configure --with-apxs=/usr/bin/apxs && make && make install'
        cwd "#{node['httpd']['MODJK_TAR_DIR']}/native"
        action :run
    end
end

cookbook_file "#{node['httpd']['MODJK_REM_CONF']}" do
  source "#{node['httpd']['MODJK_CONF']}"
  action :create
end

template "#{node['httpd']['WORKERS_REM_FILE']}" do
  source "#{node['httpd']['WORKERS_FILE']}"
  action :create
end

