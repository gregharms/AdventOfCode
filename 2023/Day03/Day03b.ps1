function Test-RangeOverlap {
    param(
        [int[]]$Range1,
        [int[]]$Range2
    )

    # Check if the ranges intersect
    if ($Range1[0] -le $Range2[-1] -and $Range1[-1] -ge $Range2[0]) {
        return $true  # Ranges intersect
    }

    return $false  # Ranges do not intersect
}

# $data = Get-Content ./AdventOfCode2023/Day03/example.txt
$data = Get-Content ./AdventOfCode2023/Day03/input.txt

$lineNum = 0
$totalLines = $data.Count
$gearRatioTally = 0
foreach ($line in $data) {
    # $line
    $lineNum += 1
    $lineChars = [regex]::Matches($line, '\*')
    if ($lineChars) {
        $lineChars | Add-Member -MemberType ScriptProperty -Name LastIndex -Value { $this.index + $this.Length - 1 }
        $lineChars | Add-Member -MemberType ScriptProperty -Name Range -Value { ($this.index..$this.lastindex) }
        if ($lineNum -gt 1) {
            $prevLine = $data[$lineNum - 2]
            $prevLineNums = [regex]::Matches($prevLine, '\d+')
            if ($prevLineNums) {
                $prevLineNums | Add-Member -MemberType ScriptProperty -Name LastIndex -Value { $this.index + $this.Length - 1 }
                $prevLineNums | Add-Member -MemberType ScriptProperty -Name Range -Value { ($this.index..$this.lastindex) }
            }
        }
        else {
            $prevLine = $null
            $prevLineNums = $null
        }
        if ($lineNum -lt $totalLines) {
            $nextLine = $data[$lineNum]
            $nextLineNums = [regex]::Matches($nextLine, '\d+')
            if ($nextLineNums) {
                $nextLineNums | Add-Member -MemberType ScriptProperty -Name LastIndex -Value { $this.index + $this.Length - 1 }
                $nextLineNums | Add-Member -MemberType ScriptProperty -Name Range -Value { ($this.index..$this.lastindex) }
            }
        }
        else {
            $nextLine = $null
            $nextLineNums = $null
        }
        $numsInLine = [regex]::Matches($line, '\d+')

        if ($numsInLine) {
            $numsInLine | Add-Member -MemberType ScriptProperty -Name LastIndex -Value { $this.index + $this.Length - 1 }
            $numsInLine | Add-Member -MemberType ScriptProperty -Name Range -Value { ($this.index..$this.lastindex) }
        }
        # look for range overlap in previous, current and next lines
        foreach ($char in $lineChars) {
            $partNumArr = @()
            $rangeStart = if ($char.index -eq 0) { 
                0 
            } 
            else { 
                $char.index - 1 
            }
            $rangeEnd = if ($char.index -eq ($line.Length - 1)) {
                $char.Index
            }
            else {
                $char.Index + 1
            }
            $rangeChar = ($rangeStart..$rangeEnd)
            if ($prevLineNums) {
                foreach ($num in $prevLineNums) {
                    $overlap = Test-RangeOverlap -Range1 $rangeChar -Range2 $num.range
                    if ($overlap) {
                        # "$($num.value) matched"
                        $partNumArr += $num.value
                    }
                }
            }
            if ($numsInLine) {
                foreach ($num in $numsInLine) {
                    $overlap = Test-RangeOverlap -Range1 $rangeChar -Range2 $num.range
                    if ($overlap) {
                        # "$($num.value) matched"
                        $partNumArr += $num.value
                    }
                }
            }
            if ($nextLineNums) {
                foreach ($num in $nextLineNums) {
                    $overlap = Test-RangeOverlap -Range1 $rangeChar -Range2 $num.range
                    if ($overlap) {
                        # "$($num.value) matched"
                        $partNumArr += $num.value
                    }
                }
            }
            if ($partNumArr.count -eq 2 ) {
                $gearRatioTally += [int]$partNumArr[0] * [int]$partNumArr[1]
            }
        }
    }
    else {
        $numsInLine = $null
        $lineChars = $null
    }
}

$gearRatioTally