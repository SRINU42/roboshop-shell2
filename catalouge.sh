echo -e "\e[33m  dowload NodeJS file  \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m  Install NodeJS  \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m  Adding a Roboshop user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Creating a app Directory  \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Dowloading and unzip the Catalogue Contend \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/catalogue.zip v

echo -e "\e[33m Install  nodes  \e[0m"
cd /app &>>/tmp/roboshop.log
npm install &>>/tmp/roboshop.log

echo -e "\e[33m Creating the Catalogue Services \e[0m"
cp /home/centos/roboshop-shell2/catalouge.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33m SystemD run  \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log

echo -e "\e[33m mongodb repo file  \e[0m"
cp /home/centos/roboshop-shell2/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log


echo -e "\e[33m install mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33m  Loading the catalouge \e[0m"
mongo --host mongodb-dev.devopssessions.store </app/schema/catalogue.js &>>/tmp/roboshop.log