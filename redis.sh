source common.sh
component=redis

echo -e "${color} Installing the Repo file ${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}

echo -e "${color} Enable the ${component} 6 Version ${nocolor}"
yum module enable ${component}:remi-6.2 -y &>>${log_file}

echo -e "${color} Install ${component} ${nocolor}"
yum install ${component} -y &>>${log_file}

echo -e "${color}  ${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/${component}.conf /etc/${component}/${component}.conf &>>${log_file}

echo -e "${color} Enable and Start the ${component} ${nocolor}"
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}