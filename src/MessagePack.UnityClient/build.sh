#!/bin/bash

while getopts l: opts; do
   case ${opts} in
      l) LOGFILE=${OPTARG} ;;
   esac
done

SCRIPT_DIR=$(dirname "$(realpath $0)")

if ! [[ -v LOGFILE ]] ; then
    LOGFILE=${SCRIPT_DIR}/../../bin/build_logs/unity_package.log
fi
LOGDIR=$(dirname "${LOGFILE}")
if ! [ -d $LOGDIR ] ; then
   mkdir -p $LOGDIR
fi

echo Writing log to ${LOGFILE}

$UNITYHUB_EDITORS_FOLDER_LOCATION/Unity \
    -batchmode \
    -quit \
    -nographics \
    -silent-crashes \
    -buildTarget standalone \
    -projectPath ${SCRIPT_DIR} \
    -executeMethod PackageExporter.Export \
    -logfile ${LOGFILE}

UnityExitCode=$?

echo Log follows...

cat ${LOGFILE}

exit $UnityExitCode
