#$contents = get-content C:\ProgramData\Aldelo For Restaurants\Backup\aldelo.t
$time = (Get-Date)
$time -replace "[, :/PM]"
#$content = $contents.split(",")[2] -replace '[""]'
#$file = $content
#$file.lastwritetime = (get-date)
#dir -recurse | where {((get-date)-$_.creationTime).days -gt 5} | remove-item -force

$files=get-ChildItem
#$files
#if($files.count -gt $keep){ $files.group| Sort-Object CreationTime | select-object -first ($files.count - $keep)| remoce-item -force
#exit