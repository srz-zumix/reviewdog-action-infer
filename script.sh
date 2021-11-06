#!/bin/sh

# shellcheck disable=SC2086

cd "${GITHUB_WORKSPACE}" || exit

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" "${REVIEWDOG_VERSION}" 2>&1
echo '::endgroup::'

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

echo '::group:: Checking infer report with reviewdog 🐶 ...'
reviewdog \
    -efm="%E%f:%l: %trror: %m" \
    -efm="%E%f:%l: %tarning: %m" \
    -efm="%C%m" \
    -efm="%Z\\ \\ %n.\\ %.%#" \
    -efm="%-G%.%#" \
    -name="${INPUT_TOOL_NAME}" \
    -reporter="${INPUT_REPORTER}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    -level="${INPUT_LEVEL}" \
    ${INPUT_REVIEWDOG_FLAGS} \
    < "${INPUT_REPORT_PATH}/report.txt"
EXIT_CODE=$?
echo '::endgroup::'

exit $EXIT_CODE
