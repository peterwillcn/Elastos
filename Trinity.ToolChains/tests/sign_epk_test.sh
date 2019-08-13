#!/bin/sh

testUsage() {
  ${testCmd} >${stdoutF} 2>${stderrF}

  grep "usage: sign_epk" ${stderrF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testSignEpk() {
  ${testCmd} -k ${keystore} -p ${password} -o ${output_epk} ${epk}>${stdoutF} 2>${stderrF}

  th_assertTrueWithNoStderr "${stderrF}"

  th_assertSignEpk ${output_epk}
}

testSignEpkOverride() {
  cp ${epk} ${epkCopy}

  ${testCmd} -k ${keystore} -p ${password} ${epkCopy}>${stdoutF} 2>${stderrF}

  th_assertSignEpk ${epkCopy}
}

testSignEpkWithErrorKeystore() {
  ${testCmd} -k ${keystoreInvalid} -p ${password} -o ${output_epk} ${epk}>${stdoutF} 2>${stderrF}

  grep "Error: Failed to sign EPK" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testSignEpkWithNoSignKeystore() {
  ${testCmd} -k ${keystoreNoSign} -p ${password} -o ${output_epk} ${epk}>${stdoutF} 2>${stderrF}

  grep "spvsdk Unsupport keystore" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0

  grep "Error: Failed to sign EPK" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testSignEpkWithNoSpvKeystore() {
  ${testCmd} -k ${keystoreSpv} -p ${password} -o ${output_epk} ${epk}>${stdoutF} 2>${stderrF}

  grep "spvsdk Unsupport keystore" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0

  grep "Error: Failed to sign EPK" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testSignEpkWithErrorPWD() {
  ${testCmd} -k ${keystore} -p "errorpwd" -o ${output_epk} ${epk}>${stdoutF} 2>${stderrF}

  grep "{\"Code\":20003,\"Message\":\"Wrong passwd\"}" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0

  grep "Error: Failed to sign EPK" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testSignEpkWithSignedEpk() {
  ${testCmd} -k ${keystore} -p ${password} -o ${output_epk} ${epk}>${stdoutF} 2>${stderrF}
  mv ${output_epk} ${epkSigned}

  ${testCmd} -k ${keystore} -p ${password} -o ${output_epk} ${epkSigned}>${stdoutF} 2>${stderrF}

  grep "Error: The EPK file already signed" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testSignEpkWithErrorEpk() {
  ${testCmd} -k ${keystore} -p ${password} -o ${output_epk} ${epkNoManifest}>${stdoutF} 2>${stderrF}

  grep "Error: Could not find \"manifest.json\". Not an EPK file?" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

th_assertTrueWithNoStderr() {
  th_stderr_=$1

  assertFalse 'unexpected output to STDERR' "[ -s '${th_stderr_}' ]"

  unset th_stderr_
}

th_assertSignEpk() {
  th_epkfile=$1
  assertTrue 'signed epk missing' "[ -f '${th_epkfile}' ]"

  # check FILELIST.inf,FILELIST.SHA,FILELIST.SIGN,SIGN.PUB
  ${verrifyCmd} ${th_epkfile}>${stdoutF} 2>${stderrF}

  grep "The signer's public key is:" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

oneTimeSetUp() {
  scriptPath="$(cd "$(dirname "$0")" && pwd -P )"

  outputDir="${SHUNIT_TMPDIR}/output"
  # outputDir="${scriptPath}/output"
  mkdir "${outputDir}"
  stdoutF="${outputDir}/stdout"
  stderrF="${outputDir}/stderr"

  if [ -z "${PYTHON3}" ]; then
    testCmd="${scriptPath}/../bin/sign_epk"
    verrifyCmd="${scriptPath}/../bin/verify_epk"
  else
    testCmd="python3 ${scriptPath}/../bin/sign_epk"
    verrifyCmd="python3 ${scriptPath}/../bin/verify_epk"
  fi

  epk="${scriptPath}/epks/fortest1.epk"
  epkNoManifest="${scriptPath}/epks/nomanifest.epk"
  epkSigned="${scriptPath}/epks/epk-signed.epk"
  epkCopy="${scriptPath}/epks/epk-copy.epk"

  keystore="${scriptPath}/keystores/web-keystore.aes.json"
  keystoreNoSign="${scriptPath}/keystores/web-keystore-noSign.aes.json"
  keystoreSpv="${scriptPath}/keystores/spv-keystore-single.aes.json"
  keystoreInvalid="${scriptPath}/keystores/invalid-keystore.json"

  password='elastos2018'

  output_epk="${scriptPath}/epk-signed-out.epk"
}

setUp() {
  rm -f "${stdoutF}"
  rm -f "${stderrF}"
}

tearDown() {
  rm -f "${output_epk}"

  if [ ${__shunit_testSuccess}  -ne 0 ]; then
    echo "stdoutF:"
    cat "${stdoutF}"
    echo "stderrF:"
    cat "${stderrF}"
  fi
}

# Load and run shUnit2.
[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. shunit2
