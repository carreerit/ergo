packages=["httpd", "httpd-devel"]
packages.each do |package|
	puts "#{package}"
end

%w(httpd httpd-devel ).each do |package|
        puts "#{package}"
end

