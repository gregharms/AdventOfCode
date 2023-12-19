# $data = Get-Content ./AdventOfCode2023/Day03/example.txt
$data = Get-Content ./AdventOfCode2023/Day03/input.txt

$lineNum = 0
$totalLines = $data.count
$partTally = 0
foreach ($line in $data) {
    $lineNum += 1
    $numsInLine = [regex]::Matches($line, '\d+')
    $lineChars = [regex]::Matches($line, '[^\w\s.]')
    if ($lineNum -gt 1) {
        $prevLine = $data[$lineNum - 2]
        $prevLineChars = [regex]::Matches($prevLine, '[^\w\s.]')
    }
    else {
        $prevLine = $null
        $prevLineChars = $null
    }
    if ($lineNum -lt $totalLines) {
        $nextLine = $data[$lineNum]
        $nextLineChars = [regex]::Matches($nextLine, '[^\w\s.]')
    }
    else {
        $nextLine = $null
        $nextLineChars = $null
    }
    foreach ($num in $numsInLine) {
        $validNum = $false
        $lowEnd = if ($num.Index -eq 0) {
            $num.Index 
        }
        else {
            $num.Index - 1
        }
        $highEnd = $num.Index + $num.Length
        $range = ($lowEnd..$highEnd)
        if ($prevLineChars) {
            foreach ($char in $prevLineChars) {
                if ($range -contains $char.Index) {
                    $validNum = $true
                }
            }
        }
        if ($nextLineChars) {
            foreach ($char in $nextLineChars) {
                if ($range -contains $char.Index) {
                    $validNum = $true
                }
            }
        }
        foreach ($char in $lineChars) {
            if ($range -contains $char.Index) {
                $validNum = $true
            }
        }
        "$validNum - $($num.value) is valid"
        if ($validNum) {
            $partTally += $num.value
        }
    }
}

"tally: $partTally"
