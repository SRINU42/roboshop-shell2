source common.sh
component=shipping

mysql_root_password=$1
if [ -z "$mysql_root_password" ]; then
    echo "MySql Passowrd missing"
    exit 1
fi

maven