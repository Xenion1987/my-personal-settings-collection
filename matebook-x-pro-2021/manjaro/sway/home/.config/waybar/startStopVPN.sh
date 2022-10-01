#! /usr/bin/env bash

PRITUNL_CLIENT=$(type pritunl-client|awk '{print $NF}')
PARAM=$1
ID=""
PIN=""

case $PARAM in
    start)
	echo "${PRITUNL_CLIENT} ${PARAM} ${ID} -p ${PIN}"
	${PRITUNL_CLIENT} "${PARAM}" "${ID}" -p "${PIN}"
	;;
    stop)
	echo "${PRITUNL_CLIENT} ${PARAM} ${ID}"
	${PRITUNL_CLIENT} "${PARAM}" "${ID}"
	;;
    *)
	exit 255
	;;
esac
