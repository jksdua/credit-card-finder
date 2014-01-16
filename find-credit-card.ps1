$REGEX = [regex]"(?im)(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})"

$global:found = 0

function Scan([string]$path) {
  $fc = new-object -com scripting.filesystemobject
  $folder = $fc.getfolder($path)

  try {
    foreach ($i in $folder.files) {
      try {
        $fileContents = [system.io.file]::ReadAllText([string]$i.Path)
        $matches = Select-String -pattern $REGEX -input $fileContents -AllMatches

        if ($matches) {
          "File: " + [string]$i.Path
          "-------------------------"
          $global:found += $matches.matches.length
          $matches | Foreach {$_.matches.value}
          ""
        }
      } catch [Exception] {
        "Failed to process file " + $i.Path
      }
    }
  } catch [Exception] {
    "Failed to process folder " + $i
  }

  try {
    foreach ($i in $folder.subfolders) {
      Scan($i.path)
    }
  } catch [Exception] {
    "Failed to process folder " + $i
  }
}

"==== CC Finder: ===="
""
"Remember to run me as an Administrator if scanning system directories such as Program Files."
""
$path = Read-Host 'Filesystem path of directory to scan (eg: C:\, C:\Users)'

Scan($path)
"Total found: " + $found

# Sample credit card data for testing
#378282246310005
#371449635398431

# to read files line by line
# http://stackoverflow.com/questions/4192072/how-to-process-a-file-in-powershell-line-by-line-as-a-stream