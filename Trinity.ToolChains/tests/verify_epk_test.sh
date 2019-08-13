#!/bin/sh

testUsage() {
  ${testCmd} >${stdoutF} 2>${stderrF}

  grep "usage: verify_epk" ${stderrF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testSignedEpk() {
  ${testCmd} ${epkSigned}>${stdoutF} 2>${stderrF}

  th_assertTrueWithNoStderr "${stderrF}"
}

testUnsignedEpk() {
  ${testCmd} ${epkUnsigned}>${stdoutF} 2>${stderrF}

  grep "Error: The EPK file hasn't been signed." ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testNoManifestEpk() {
  ${testCmd} ${epkNoManifest}>${stdoutF} 2>${stderrF}

  grep "Error: Could not find \"manifest.json\". Not an EPK file?" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testNoINFEpk() {
  ${testCmd} ${epkNoINF}>${stdoutF} 2>${stderrF}

  grep "Error: The file EPK-SIGN/FILELIST.INF not found in the EPK." ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testNoSHAEpk() {
  ${testCmd} ${epkNoSHA}>${stdoutF} 2>${stderrF}

  grep "Error: The file EPK-SIGN/FILELIST.SHA not found in the EPK." ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testNoSIGNEpk() {
  ${testCmd} ${epkNoSIGN}>${stdoutF} 2>${stderrF}

  grep "Error: The file EPK-SIGN/FILELIST.SIGN not found in the EPK." ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testNoPUBEpk() {
  ${testCmd} ${epkNoPUB}>${stdoutF} 2>${stderrF}

  grep "Error: The file EPK-SIGN/SIGN.PUB not found in the EPK." ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

testErrorPUBEpk() {
  ${testCmd} ${epkErrorPUB}>${stdoutF} 2>${stderrF}

  grep "Error: EPK not signed properly." ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

#change index.html
testChangeFileEpk() {
  ${testCmd} ${epkFileChanged}>${stdoutF} 2>${stderrF}

  grep "Error: Digest not matched." ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

#change index.html and FILELIST.INF
testChangeFile2Epk() {
  ${testCmd} ${epkFileChanged2}>${stdoutF} 2>${stderrF}

  grep "Error: The EPK digest not match FILELIST.SHA" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

#change index.html, FILELIST.INF and FILELIST.SIGN
testChangeFile3Epk() {
  ${testCmd} ${epkFileChanged3}>${stdoutF} 2>${stderrF}

  grep "Error: EPK not signed properly" ${stdoutF} >/dev/null
  rtrn=$?

  assertEquals ${rtrn} 0
}

th_assertTrueWithNoStderr() {
  th_stderr_=$1

  assertFalse 'unexpected output to STDERR' "[ -s '${th_stderr_}' ]"

  unset th_stderr_
}

oneTimeSetUp() {
  scriptPath="$(cd "$(dirname "$0")" && pwd -P )"

  outputDir="${SHUNIT_TMPDIR}/output"
  # outputDir="${scriptPath}/output"
  mkdir "${outputDir}"
  stdoutF="${outputDir}/stdout"
  stderrF="${outputDir}/stderr"


  if [ -z "${PYTHON3}" ]; then
    testCmd="${scriptPath}/../bin/verify_epk"
  else
    testCmd="python3 ${scriptPath}/../bin/verify_epk"
  fi

  epkUnsigned="${scriptPath}/epks/fortest1.epk"
  epkNoManifest="${scriptPath}/epks/nomanifest.epk"
  epkNoINF="${scriptPath}/epks/noINF.epk"
  epkNoSHA="${scriptPath}/epks/noSHA.epk"
  epkNoSIGN="${scriptPath}/epks/noSIGN.epk"
  epkNoPUB="${scriptPath}/epks/noPUB.epk"
  epkErrorPUB="${scriptPath}/epks/errorPUB.epk"
  epkFileChanged="${scriptPath}/epks/FileChanged.epk"
  epkFileChanged2="${scriptPath}/epks/FileChanged2.epk"
  epkFileChanged3="${scriptPath}/epks/FileChanged3.epk"
  epkSigned="${scriptPath}/epks/epk-signed.epk"
}

setUp() {
  rm -f "${stdoutF}"
  rm -f "${stderrF}"
}

tearDown() {
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
