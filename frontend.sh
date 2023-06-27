echo -e "\e[33m install niginx \e[0m"
yum install nginx -y &>>/temp/roboshop.log 

echo -e "\e[33m install niginx \e[0m"
rm -rf /usr/share/nginx/html/* &>>/temp/roboshop.log

echo -e "\e[33m install niginx \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/temp/roboshop.log

echo -e "\e[33m install niginx \e[0m"
cd /usr/share/nginx/html &>>/temp/roboshop.log
unzip /tmp/frontend.zip &>>/temp/roboshop.log

#echo -e "\e[33m install niginx \e[0m"
#cp 

echo -e "\e[33m install niginx \e[0m"
systemctl enable nginx &>>/temp/roboshop.log
systemctl restart nginx &>>/temp/roboshop.log
