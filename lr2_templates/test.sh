#!/usr/bin/env bash

RED='\033[0;31m'
GRN='\033[0;32m'
NC='\033[0m' # No Color

# @brief path to verificator
VERIFICATOR='./pan'

# @brief LTL-formula name
LTL="${1:-p1}"

# @brief expected errors
EXPECTED_ERRORS="${2:-0}"

# @brief message
MSG="${3}"


set -euo pipefail

[ ! -f "${VERIFICATOR}" ] && exit 2 # ENOENT

ACTUAL_ERRORS=$("${VERIFICATOR}" -a -N "${LTL}" | grep -Eo 'errors: [0-9]+' | cut -d' ' -f2)
if [ "${ACTUAL_ERRORS}" -ne "${EXPECTED_ERRORS}" ]; then
    echo -e "${RED}[FAIL]${NC}: testing ${LTL} - ${MSG}: expected ${EXPECTED_ERRORS}, found ${ACTUAL_ERRORS}"
    exit 1
fi

echo -ne "${GRN}["
if [ "${ACTUAL_ERRORS}" -gt 0 ]; then
    echo -n 'XFAIL'
else
    echo -n 'PASS '
fi
echo -e "]${NC}: testing ${LTL} - ${MSG}"
