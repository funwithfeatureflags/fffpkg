#! /bin/sh

### BEGIN INIT INFO
# Provides:        flagd
# Required-Start:    $remote_fs $network $syslog
# Required-Stop:    $remote_fs $network $syslog
# Default-Start:    2 3 4 5
# Default-Stop:        
# Short-Description:    flagd
### END INIT INFO

PIDFILE=/var/run/flagd/flagd.pid
CONF=/etc/flagd/flagd.ini
USER=flagd
GROUP=flagd
BIN=/usr/bin/flagd
OPTS="-d -c $CONF -p $PIDFILE"

. /lib/lsb/init-functions

if [ -f /etc/default/flagd ]; then
    . /etc/default/flagd
fi

start_flagd(){
    log_daemon_msg "Starting flagd" "flagd" || true
    pidofproc -p $PIDFILE $BIN >/dev/null
    status="$?"
    if [ $status -eq 0 ]
    then
        log_end_msg 1 
        log_failure_msg \
        "flagd already started"
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

stop_flagd(){
    log_daemon_msg "Stopping flagd" "flagd" || true
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
    start_flagd
    exit $?
    ;;
  stop)
    stop_flagd
    exit $?
    ;;
  restart)
    stop_flagd
    wait_stop
    start_flagd
    exit $?
    ;;
  status)
    status_of_proc -p $PIDFILE $BIN "flagd" \
        && exit 0 || exit $?
    ;;
  *)
    log_action_msg \
    "Usage: /etc/init.d/flagd {start|stop|restart|status}" \
    || true
    exit 1
esac

exit 0
