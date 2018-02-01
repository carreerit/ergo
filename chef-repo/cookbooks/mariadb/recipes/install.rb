package 'mariadb-server' do
  action :install
end

service 'mariadb' do
  action :start
end

cookbook_file '/tmp/student.sql' do
  source 'student.sql'
  action :create
end

execute 'Load student schema' do
  command 'mysql </tmp/student.sql'
  action :run
end



