echo -e "\e[33m  dowload NodeJS file  \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m  Install NodeJS  \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m  Adding a Roboshop user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Creating a app Directory  \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Dowloading and unzip the user Contend \e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app 
unzip /tmp/user.zip &>>/tmp/roboshop.log

echo -e "\e[33m Install  nodes  \e[0m"
cd /app 
npm install &>>/tmp/roboshop.log

echo -e "\e[33m Creating the user Services \e[0m"
cp /home/centos/roboshop-shell2/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[33m SystemD run  \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl restart user &>>/tmp/roboshop.log

echo -e "\e[33m mongodb repo file  \e[0m"
cp /home/centos/roboshop-shell2/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log


echo -e "\e[33m install mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33m  Loading the catalouge \e[0m"
mongo --host mongodb-dev.devopssessions.store </app/schema/user.js &>>/tmp/roboshop.log