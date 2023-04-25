$sourcefolder="C:\temp\HWinfo\HWinfo"
$destination="C:\temp\temp.csv"

$files=get-childitem "$sourcefolder\*.txt"

$array=@()
foreach($file in $files){
    $object=@{}
    $filecont=get-content $file.FullName
    foreach($line in $filecont){
        if(($line.trim() -ne '') -and ($line.split(':').length -gt 1)){
            #write-host "$line"
            $property=$line.Split(":")[0]
            $value=$line.Split(":")[1]
            $object|Add-Member -MemberType NoteProperty -Name "$property" -Value "$Value"
        }
    }
    $array+=$object
}

$array|select computername,"OS Name", "OS Version"|export-csv $destination -NoTypeInformation
