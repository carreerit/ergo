name "stack"
description "web+app+db"
run_list "recipe[httpd::config]", "recipe[httpd::modjk]", "recipe[tomcat::install]"
