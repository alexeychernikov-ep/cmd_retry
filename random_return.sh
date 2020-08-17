#!/bin/bash

set -euo pipefail
IFS=$' \n\t'

SRCPATH=$(readlink -f "${0}")
WORKDIR=$(dirname "${SRCPATH}")
cd "${WORKDIR}"

set +e

[ ${RANDOM} -lt 16383 ]
return_code=${?}

set -e

exit ${return_code}
