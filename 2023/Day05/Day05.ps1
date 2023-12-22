$dayNum = "05"
$AoCdayPath = "./AdventOfCode/2023/Day$dayNum"

$data = Get-Content "$($AoCdayPath)/example.txt"
# $data = Get-Content "$($AoCdayPath)/input.txt"

function mapper {
    $emptyMap = New-Object System.Collections.Generic.List[object]
    for ($i = 0; $i -le 99; $i++) {
        $emptyMap.Add(
            [PSCustomObject]@{
                dest = $i
                src  = $i
            })
    }
    $emptyMap
}

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
        $mappingTable = mapper
    }

    if ($data[$i] -eq '') {
        $sourceName = $null
        $destinationName = $null
    }
    else {
        [int[]]$nums = ([regex]::Matches($data[$i], '\d+')).Value
        $destination = $nums[0]
        $source = $nums[1]
        $rangeLength = $nums[2]
    
        for ($j = $rangeLength; $j -gt 0; $j--) {
            ($mappingTable | Where-Object { $_.src -eq $source }).dest = $destination
            $source++
            $destination++
        }
        foreach ($seed in $seedMap) {
            #"Setting $destinationName for $($seed.$sourceName)"
            $seed.$destinationName = ($mappingTable | Where-Object { $_.src -eq $seed.$sourceName }).dest
        }
    }
}
$lowLoc = ($seedMap | Sort-Object -Property location | Select-Object -First 1).location
"Lowest Location: $lowLoc"
$lowLoc | Set-Clipboard