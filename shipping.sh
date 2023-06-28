echo -e "\e[33m Install  maven  \e[0m"
yum install maven -y &>>/tmp/roboshop.log

echo -e "\e[33m Roboshop User adding  \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Creating App Directory  \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Dowload the Shipping Contend  \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 
cd /app 
unzip /tmp/shipping.zip &>>/tmp/roboshop.log

echo -e "\e[33m dowload Maven Dependencies  \e[0m" 
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log




echo -e "\e[33m Installing the MYSQL \e[0m"
yum install mysql -y &>>/tmp/roboshop.log

echo -e "\e[33m Load Schema  \e[0m"
mysql -h mysql-dev.devopssessions.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log

echo -e "\e[33m Copy the shipping service  \e[0m"
cp /home/centos/roboshop-shell2/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log

echo -e "\e[33m start the SystemD \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log