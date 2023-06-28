echo -e "\e[33m Installing the Python3 \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log

echo -e "\e[33m Adding the Roboshop User \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Adding the Application Directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Dowloading the application content a \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log
unzip /tmp/payment.zip &>>/tmp/roboshop.log

echo -e "\e[33m installing pip3.6 \e[0m"
cd /app 
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log

echo -e "\e[33m Start the Systemd Services \e[0m"
cp /home/centos/roboshop-shell2/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log

echo -e "\e[33m Start the Application Shema \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log
