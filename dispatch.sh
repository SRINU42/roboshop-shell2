source common.sh
component=dispatch


echo -e "${color} Installing Golang${nocolor}"
yum install golang -y &>>${log_file}

echo -e "${color} adding Roboshop User ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} Creating Application Directory ${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${color} Dowloading applicatin Content ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
cd ${app_path} 
unzip /tmp/${component}.zip &>>${log_file}

echo -e "${color} Init ${component} ${nocolor}"
cd ${app_path} &>>${log_file}
go mod init ${component} &>>${log_file}
go get &>>${log_file}
go build &>>${log_file}

echo -e "${color} Start System service ${nocolor}"
cp /home/centos/roboshop-shell2/ ${component}.service /etc/systemd/system/${component}.service &>>${log_file}

echo -e "${color} Start SystemD  ${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}