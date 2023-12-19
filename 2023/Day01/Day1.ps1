# Calibration

#$data = Get-Content ./AdventOfCode2023/Day01/example1.txt
$data = Get-Content ./AdventOfCode2023/Day01/input.txt

$calibrationData = 0
foreach ($line in $data) {
    $digits = $line -replace '\D', ''
    #Write-Output $digits
    $twoDigits = "$($digits[0])$($digits[-1])"
    #Write-Output $twoDigits
    $calibrationData += [int]$twoDigits
}

Write-Output $calibrationData


#### part 2

#$data = Get-Content ./AdventOfCode2023/Day01/example2.txt
$data = Get-Content ./AdventOfCode2023/Day01/input.txt

$numWord = @{
    one   = "1ne"
    two   = "2wo"
    three = "3hree"
    four  = "4our"
    five  = "5ive"
    six   = "6ix"
    seven = "7even"
    eight = "8ight"
    nine  = "9ine"
}
$calibrationData = 0
foreach ($line in $data) {
    $lineOrder = New-Object Object[] $line.Length
    Write-Output "1: $line"
    foreach ($key in $numWord.Keys) {
        $firstIndex = $line.IndexOf($key)
        if ($firstIndex -ne -1) {
            #"$key found in $line"
            $lineOrder[$firstIndex] = $key
            $lastIndex = $line.LastIndexOf($key)
            if ($lastIndex -ne $firstIndex) {
                $lineOrder[$lastIndex] = $key
                #"$key found in $line again"
            }
        }
    }
    foreach ($entry in $lineOrder) {
        if ($null -ne $entry) {
            $line = $line -replace "$entry", "$($numWord.Item($entry))"
        }
    }
    Write-Output "2: $line"
    $digits = $line -replace '\D', ''
    Write-Output "3: $digits"
    $twoDigits = "$($digits[0])$($digits[-1])"
    Write-Output "4: $twoDigits"
    $calibrationData += [int]$twoDigits
}

Write-Output $calibrationData
