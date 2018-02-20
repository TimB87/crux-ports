#!/bin/sh
#
# /etc/rc.d/tlp: start/stop tlp daemon
#

SSD=/sbin/start-stop-daemon
PROG=/usr/bin/tlp
PID=/var/run/tlp.pid
OPTS=""

case $1 in
start)
	$SSD --start -bm --pidfile $PID --exec $PROG -- $OPTS
	;;
stop)
	$SSD --stop --remove-pidfile --retry 10 --pidfile $PID
	;;
restart)
	$0 stop
	$0 start
	;;
status)
	$SSD --status --pidfile $PID
	case $? in
	0) echo "$PROG is running with pid $(cat $PID)" ;;
	1) echo "$PROG is not running but the pid file $PID exists" ;;
	3) echo "$PROG is not running" ;;
	4) echo "Unable to determine the program status" ;;
	esac
	;;
*)
	echo "usage: $0 [start|stop|restart|status]"
	;;
esac

# End of file
