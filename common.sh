color="\e[33m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

stat_check() {
   if [ $1 -eq 0 ]; then
      echo SUCCESS
    else 
      echo FAILURE
    fi 
    
}

app_presetup() {

    echo -e "${color}  Adding a Roboshop user ${nocolor}"
    id roboshop &>>${log_file}
    if [ $? -eq 1 ]; then
    useradd roboshop &>>${log_file}
    fi

    stat_check $?

    echo -e "${color} Creating a app Directory  ${nocolor}"
    rm -rf ${app_path} &>>${log_file}
    mkdir ${app_path} &>>${log_file}

    stat_check $?

    echo -e "${color} Dowloading and unzip the ${component} Contend ${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
    cd ${app_path} 
    unzip /tmp/${component}.zip &>>${log_file}
    stat_check $?
}

systemd_setup() {

    echo -e "${color} Creating the ${component} Services ${nocolor}"
    cp /home/centos/roboshop-shell2/${component}.service /etc/systemd/system/${component}.service &>>${log_file}
    sed -i -e 's/roboshop_app_password/$roboshop_app_password/' /etc/systemd/system/${component}.service 
    stat_check $?

    echo -e "${color} SystemD run  ${nocolor}"
    systemctl daemon-reload &>>${log_file}
    systemctl enable ${component} &>>${log_file}
    systemctl restart ${component} &>>${log_file}
    stat_check $? 

}




nodejs() {
    echo -e "${color}  dowload NodeJS file  ${nocolor}"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

    echo -e "${color}  Install NodeJS  ${nocolor}"
    yum install nodejs -y &>>${log_file}
    stat_check $? 

    app_presetup

   
    echo -e "${color} Install  nodes  ${nocolor}"
    cd ${app_path} 
    npm install &>>${log_file}
    stat_check $? 

    systemd_setup

}

mongo_schema_setup() {

    echo -e "${color} mongodb repo file  ${nocolor}"
    cp /home/centos/roboshop-shell2/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}
    stat_check $? 

    echo -e "${color} install mongodb ${nocolor}"
    yum install mongodb-org-shell -y &>>${log_file}
    stat_check $? 

    echo -e "${color}  Loading the catalouge ${nocolor}"
    mongo --host mongodb-dev.erobo.online <${app_path}/schema/${component}.js &>>${log_file}
    stat_check $? 
}


mysql_schema_setup() {

    echo -e "${color} Installing the MYSQL ${nocolor}"
    yum install mysql -y &>>${log_file}
    echo $?
    stat_check $? 

    echo -e "${color} Load Schema  ${nocolor}"
    mysql -h mysql-dev.erobo.online -uroot -p${mysql_root_password} < ${app_path}/schema/${component}.sql &>>${log_file}
    stat_check $? 

}



maven() {

    echo -e "${color} Install  maven  ${nocolor}"
    yum install maven -y &>>${log_file}

    app_presetup


    echo -e "${color} dowload Maven Dependencies  ${nocolor}" 
    mvn clean package &>>${log_file}
    mv target/${component}-1.0.jar ${component}.jar &>>${log_file}

    mysql_schema_setup

    systemd_setup 
}


python() {

    echo -e "${color} Installing the Python3 ${nocolor}"
    yum install python36 gcc python3-devel -y &>>${log_file}
    stat_check $?

    app_presetup

    echo -e "${color} installing pip3.6 ${nocolor}"
    cd ${app_path} 
    pip3.6 install -r requirements.txt &>>${log_file}
    stat_check $? 

    systemd_setup

}