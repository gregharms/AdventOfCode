$dayNum = "05"
$AoCdayPath = "./AdventOfCode/2023/Day$dayNum"

# $data = Get-Content "$($AoCdayPath)/example.txt"
$data = Get-Content "$($AoCdayPath)/input.txt"

$lines = $data.count

$seeds = ([regex]::Matches($data[0].split(':')[1], '\d+')).Value

$seedMap = New-Object System.Collections.Generic.List[object]
foreach ($seed in $seeds) {
    $seedMap.Add(
        [PSCustomObject]@{
            seed        = $seed
            soil        = $null
            fertilizer  = $null
            water       = $null
            light       = $null
            temperature = $null
            humidity    = $null
            location    = $null
        }
    )
}

for ($i = 2; $i -lt $lines; $i++) {
    if ($data[$i] -like "*:") {
        $map = $data[$i].split(' ')[0]
        $destinationName = $map.split('-')[2]
        $sourceName = $map.split('-')[0]
        #"$i - $sourceName to $destinationName"
        $i++
        $mappingTable = New-Object System.Collections.Generic.List[object]
    }

    if ($data[$i] -eq '') {
        $sourceName = $null
        $destinationName = $null
    }
    else {
        $nums = ([regex]::Matches($data[$i], '\d+')).Value
        $destination = $nums[0]
        $source = $nums[1]
        $rangeLength = $nums[2]
    
        for ($j = $rangeLength; $j -gt 0; $j--) {
            $mappingTable.Add(
                [PSCustomObject]@{
                    dest = $destination
                    src  = $source
                })
            $source++
            $destination++
        }
        foreach ($seed in $seedMap) {
            #"Setting $destinationName for $($seed.$sourceName)"
            $destinationValue = ($mappingTable | Where-Object { $_.src -eq $seed.$sourceName }).dest
            $seed.$destinationName = if ($destinationValue) { $destinationValue } else { $seed.$sourceName }
        }
    }
}
$lowLoc = ($seedMap | Sort-Object -Property location | Select-Object -First 1).location
"Lowest Location: $lowLoc"
$lowLoc | Set-Clipboard