name "web"
description "The base role for systems that serve HTTP traffic"
run_list "recipe[httpd::config]", "recipe[httpd::modjk]"
