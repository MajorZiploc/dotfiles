$logName = 'choco'
$logSource = 'upgrade'
function Upgrade-Choco {
  cup all -y --except="python3"
}

function Program {
  param ()

process {
try {
  $msg = "Started process"
  Upgrade-Choco -ErrorAction SilentlyContinue -ErrorVariable ProcessError
  if ($ProcessError) {
    $msg = "Something went wrong. $ProcessError"
  } else {
    $msg = "Successful upgrade"
  }
}
catch {
  $msg = $_.ToString()
}
}

end {
  $msg = "Finished process"
}
}

Program
