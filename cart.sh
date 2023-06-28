echo -e "\e[33m  dowload NodeJS file  \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m  Install NodeJS  \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m  Adding a Roboshop Cart \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Creating a app Directory  \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Dowloading and unzip the cart Contend \e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app 
unzip /tmp/cart.zip &>>/tmp/roboshop.log

echo -e "\e[33m Install  nodes  \e[0m"
cd /app 
npm install &>>/tmp/roboshop.log

echo -e "\e[33m Creating the cart Services \e[0m"
cp /home/centos/roboshop-shell2/cart.service /etc/systemd/system/cart.service 

echo -e "\e[33m SystemD run  \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log

