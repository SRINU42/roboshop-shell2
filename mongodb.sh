
source common.sh
component=mongodb

echo -e "${color} mongodb repo file  ${nocolor}"
cp /home/centos/roboshop-shell2/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

echo -e "${color} install mongodb ${nocolor}"
yum install mongodb-org -y &>>${log_file}


echo -e "${color} Update MongoDB Listen Address ${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}

echo -e "${color} SystemD start  ${nocolor}"
systemctl enable mongod &>>${log_file}
systemctl restart mongod &>>${log_file}

