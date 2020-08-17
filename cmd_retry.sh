#!/bin/bash

set -euo pipefail
IFS=$' \n\t'

SRCPATH=$(readlink -f "${0}")
WORKDIR=$(dirname "${SRCPATH}")
cd "${WORKDIR}" || exit

MAX_RETRIES=5
DELAY_IN_SECONDS=5

function retry() {
	local count=0

	set +e

	while [ ${count} -lt ${MAX_RETRIES} ] && ! "${@}"
	do
		sleep ${DELAY_IN_SECONDS}s
		((count++))
		echo "Retrying ${*} command: #${count}"
	done

	[ ${count} -lt ${MAX_RETRIES} ]
	local return_code=${?}
	
	set -e

	[ ${return_code} -ne 0 ] && echo "Maximum number of attempts exceeded: ${MAX_RETRIES}"
	return ${return_code}
}

retry "${@}"

exit ${?}
