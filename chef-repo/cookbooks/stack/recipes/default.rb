#
# Cookbook:: stack
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#
include_recipe 'httpd::config'
include_recipe 'httpd::modjk'
include_recipe 'tomcat::install'
include_recipe 'mariadb::install'
