#! /bin/sh

### BEGIN INIT INFO
# Provides:        python3-openfeature-sdk
# Required-Start:    $remote_fs $network $syslog
# Required-Stop:    $remote_fs $network $syslog
# Default-Start:    2 3 4 5
# Default-Stop:        
# Short-Description:    python3-openfeature-sdk
### END INIT INFO

PIDFILE=/var/run/python3-openfeature-sdk/python3-openfeature-sdk.pid
CONF=/etc/python3-openfeature-sdk/python3-openfeature-sdk.ini
USER=python3-openfeature-sdk
GROUP=python3-openfeature-sdk
BIN=/usr/bin/python3-openfeature-sdk
OPTS="-d -c $CONF -p $PIDFILE"

. /lib/lsb/init-functions

if [ -f /etc/default/python3-openfeature-sdk ]; then
    . /etc/default/python3-openfeature-sdk
fi

start_python3-openfeature-sdk(){
    log_daemon_msg "Starting python3-openfeature-sdk" "python3-openfeature-sdk" || true
    pidofproc -p $PIDFILE $BIN >/dev/null
    status="$?"
    if [ $status -eq 0 ]
    then
        log_end_msg 1 
        log_failure_msg \
        "python3-openfeature-sdk already started"
        return 1
    fi
    mkdir -p `dirname $PIDFILE` -m 750
    chown $USER:$GROUP `dirname $PIDFILE`
    if start-stop-daemon -c $USER:$GROUP --start \
        --quiet --pidfile $PIDFILE \
        --oknodo --exec $BIN -- $OPTS
    then
        log_end_msg 0 || true
        return 0
    else
        log_end_msg 1 || true
        return 1
    fi

}

stop_python3-openfeature-sdk(){
    log_daemon_msg "Stopping python3-openfeature-sdk" "python3-openfeature-sdk" || true
    if start-stop-daemon --stop --quiet \
        --pidfile $PIDFILE
    then
        log_end_msg 0 || true
        return 0
    else
        log_end_msg 1 || true
        return 1
    fi
}

wait_stop(){
    c=0
    while pidofproc -p $PIDFILE $BIN >/dev/null && [ $c -lt 10 ]
    do
        sleep 0.5
        c=$(( $c + 1 ))
    done
}

case "$1" in
  start)
    start_python3-openfeature-sdk
    exit $?
    ;;
  stop)
    stop_python3-openfeature-sdk
    exit $?
    ;;
  restart)
    stop_python3-openfeature-sdk
    wait_stop
    start_python3-openfeature-sdk
    exit $?
    ;;
  status)
    status_of_proc -p $PIDFILE $BIN "python3-openfeature-sdk" \
        && exit 0 || exit $?
    ;;
  *)
    log_action_msg \
    "Usage: /etc/init.d/python3-openfeature-sdk {start|stop|restart|status}" \
    || true
    exit 1
esac

exit 0
