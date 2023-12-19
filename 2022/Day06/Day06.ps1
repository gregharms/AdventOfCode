$data = Get-Content .\input.txt
#$data = Get-Content .\example_input.txt

#find next mark
foreach ($line in $data) {
    $arr = $line.ToCharArray()
    $i = 0
    do {
        $marker = $arr[$i..($i+3)]
        if (($marker | Select-Object -Unique).count -eq 4) {
            "Characters Processed: $($i+4); Marker: $($marker -join '')"
            break
        }
        $i++
    } until ($unique -eq $true -or ($i + 4) -eq $arr.count)
}


# now look for 14
#find next mark
foreach ($line in $data) {
    $arr = $line.ToCharArray()
    $i = 0
    do {
        $marker = $arr[$i..($i+13)]
        if (($marker | Select-Object -Unique).count -eq 14) {
            "Characters Processed: $($i+14); Marker: $($marker -join '')"
            break
        }
        $i++
    } until ($unique -eq $true -or ($i + 14) -eq $arr.count)
}