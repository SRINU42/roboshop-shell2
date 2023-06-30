source common.sh
component=catalogue

 

nodejs

mongo_schema_setup

echo -e "${color} mongodb repo file  ${nocolor}"
cp /home/centos/roboshop-shell2/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}


echo -e "${color} install mongodb ${nocolor}"
yum install mongodb-org -y &>>${log_file}

echo -e "${color}  Loading the catalouge ${nocolor}"
mongo --host mongodb-dev.devopssessions.store <${app_path}/schema/${component}.js &>>${log_file}