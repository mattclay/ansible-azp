#!/usr/bin/env bash
# Upload code coverage reports to codecov.io.
# Multiple coverage files from multiple languages are accepted and aggregated after upload.
# That means Python coverage, as well as PowerShell and Python stubs can be uploaded.

set -o pipefail -eu

curl --silent --show-error https://codecov.io/bash > codecov.sh

for file in test/results/reports/coverage*.xml; do
  name="${file##*/coverage=}"  # remove path and 'coverage=' prefix from coverage filenames (if present)
  name="${name%.xml}"  # remove '.xml' suffix from coverage filenames

  bash codecov.sh \
    -f "${file}" \
    -n "${file}" \
    -X coveragepy \
    -X gcov \
    -X fix \
    -X search \
    -X xcode \
    || echo "Failed to upload code coverage report to codecov.io: ${file}"
done
