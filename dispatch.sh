echo -e "\e[33m Installing Golang\e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[33m adding Roboshop User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Creating Application Directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Dowloading applicatin Content \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip 
cd /app 
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[33m Init Dispatch \e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33m Start System service \e[0m"
cp /home/centos/roboshop-shell2/ dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33m Start SystemD  \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log