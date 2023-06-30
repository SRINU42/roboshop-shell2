source common.sh
component=payment


echo -e "${color} Installing the Python3 ${nocolor}"
yum install python36 gcc python3-devel -y &>>${log_file}

echo -e "${color} Adding the Roboshop User ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} Adding the Application Directory ${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${color} Dowloading the application content a ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path} &>>${log_file}
unzip /tmp/${component}.zip &>>${log_file}

echo -e "${color} installing pip3.6 ${nocolor}"
cd ${app_path} 
pip3.6 install -r requirements.txt &>>${log_file}

echo -e "${color} Start the Systemd Services ${nocolor}"
cp /home/centos/roboshop-shell2/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

echo -e "${color} Start the Application Shema ${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl restart ${component} &>>${log_file}
