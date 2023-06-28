echo -e "\e[33m Installing the Repo file \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[33m Enable the Redis 6 Version \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[33m Install Redis \e[0m"
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[33m  \e[0m"
sed -i 's/127.0.0.0/0.0.0.0' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[33m Enable and Start the Redis \e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl restart redis &>>/tmp/roboshop.log