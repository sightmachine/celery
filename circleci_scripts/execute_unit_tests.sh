#!/usr/bin/env bash
set -ex

TSTAMP=$(date -u +'%Y%m%d%H%M%S')
WORKSPACE=$(pwd)

echo "Running on host: ${HOSTNAME}" >&2

# We want to record coverage even if the tests fail, so we need to capture and
# store the exit code until after `coverage xml` runs.
cd /home/developer/celery

XML_RESULT_DIR=/home/developer/tmp/junit/
mkdir -p ${XML_RESULT_DIR}

xml_filename="${XML_RESULT_DIR}smcelery-${TSTAMP}.xml"

echo "python3.6" > /home/developer/.python-version

CMD="pyenv global python3.6"
${CMD}

CMD="\
pyenv exec coverage run --rcfile=/home/developer/celery/.coveragerc \
/home/developer/.pyenv/versions/python3.6/bin/pytest --color=no -vv --junit-xml=${xml_filename} t/unit \
"

if ${CMD} >&2
then exitcode=0
else exitcode=$?
fi

if [ ! -f $xml_filename ]; then
  # No result files, assume we core dumped
  cat >${xml_filename} <<EOF
<?xml version="1.0" encoding="utf-8"?>
<testsuite errors="1" failures="0" name="pytest" skips="0" tests="1" time="0">
    <testcase classname="" file="${pathname}" time="0">
        <error message="collection failure">
            /home/developer/celery/circleci_scripts/execute_unit_tests.sh: line 77:  \${CMD} 1&gt;&amp;2
            (core dumped)
        </error>
    </testcase>
</testsuite>
EOF
fi

exit "${exitcode}"
