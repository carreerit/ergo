
%w(httpd httpd-devel).each do |pack_name|
    package "Installing package #{pack_name}" do
        package_name "#{pack_name}"
        action :install
    end
end

service 'httpd' do
  action [ :start, :enable ]
end


