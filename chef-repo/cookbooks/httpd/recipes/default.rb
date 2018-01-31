#
# Cookbook:: httpd
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

log 'message' do
    message 'Helo from httpd default recipe'
    level :fatal
  end
