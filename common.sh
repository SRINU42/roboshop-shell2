color="\e[33m"
nocolor="\e[0m"
log_file= "/tmp/roboshop.log"
app_path="/app"



app_presetup() {

    echo -e "${color}  Adding a Roboshop user ${nocolor}"
    useradd roboshop &>>${log_file}

    echo -e "${color} Creating a app Directory  ${nocolor}"
    rm -rf ${app_path} &>>${log_file}
    mkdir ${app_path} &>>${log_file}

    echo -e "${color} Dowloading and unzip the ${component} Contend ${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
    cd ${app_path} 
    unzip /tmp/${component}.zip &>>${log_file}

}

systemd_setup() {

    echo -e "${color} Creating the ${component} Services ${nocolor}"
    cp /home/centos/roboshop-shell2/${component}.service /etc/systemd/system/${component}.service &>>${log_file}

    echo -e "${color} SystemD run  ${nocolor}"
    systemctl daemon-reload &>>${log_file}
    systemctl enable ${component} &>>${log_file}
    systemctl restart ${component} &>>${log_file}

}




nodejs() {
    echo -e "${color}  dowload NodeJS file  ${nocolor}"
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

    echo -e "${color}  Install NodeJS  ${nocolor}"
    yum install nodejs -y &>>${log_file}

    app_presetup

   
    echo -e "${color} Install  nodes  ${nocolor}"
    cd ${app_path} 
    npm install &>>${log_file}

   systemd_setup

}

mongo_schema_setup() {

    echo -e "${color} mongodb repo file  ${nocolor}"
    cp /home/centos/roboshop-shell2/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}


    echo -e "${color} install mongodb ${nocolor}"
    yum install mongodb-org -y &>>${log_file}

    echo -e "${color}  Loading the catalouge ${nocolor}"
    mongo --host mongodb-dev.devopssessions.store <${app_path}/schema/${component}.js &>>${log_file}
}

maven() {

    echo -e "${color} Install  maven  ${nocolor}"
    yum install maven -y &>>${log_file}

    app_presetup


    echo -e "${color} dowload Maven Dependencies  ${nocolor}" 
    mvn clean package &>>${log_file}
    mv target/${component}-1.0.jar ${component}.jar &>>${log_file}


    echo -e "${color} Installing the MYSQL ${nocolor}"
    yum install mysql -y &>>${log_file}

    echo -e "${color} Load Schema  ${nocolor}"
    mysql -h mysql-dev.devopssessions.store -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql &>>${log_file}

    systemd_setup 
}