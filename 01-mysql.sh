#! /bin/bash


LOGS_FOLDER="/var/log/shell-scripting "
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(DATE +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p$LOGS_FOLDER


USERID=$(id -u)
CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo " kindly run this script as root user "
    fi 
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo " $2 is failed "
    else
        echo " $2 is sucess "
    fi
}


CHECK_ROOT

apt install mysql-server -y &>>$LOG_FILE
VALIDATE $? " installing mysql server "

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? " enableing mysql server "

systemctl start mysql-server -y &>>$LOG_FILE
VALIDATE $? " starting  mysql server "

mysql_secure_insatallation --set-root-pass expenseAPP@1 &>>$LOG_FILE
VALIDATE $? " setting up the root password "


