echo -e "\e[33m mongodb repo file  \e[0m"
cp /home/centos/roboshop-shell2/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33m install mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log


echo -e "\e[33m Update MongoDB Listen Address \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>/tmp/roboshop.log

echo -e "\e[33m SystemD start  \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log

