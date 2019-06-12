
git pull

mvn clean package -Dmaven.test.skip=true
cd dubbo-admin-distribution/target

PID=$(ps -ef | grep dubbo-admin-0.2.0.jar | grep -v grep | awk '{ print $2 }')
echo $PID
if [ -z "$PID" ]
then
    echo application is already stopped...
else
    kill -9 $PID
    echo killed $PID.
fi

nohup java -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=9745,suspend=n -jar dubbo-admin-0.2.0.jar  &
tail -f /data0/www/apps/dubbo-admin/dubbo-admin-distribution/target/nohup.out