$dayNum = "04"
$AoCdayPath = "./AdventOfCode/2023/Day$dayNum"

# $data = Get-Content "$($AoCdayPath)/example.txt"
$data = Get-Content "$($AoCdayPath)/input.txt"

# $line = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"

$pileScore = 0
foreach ($line in $data) {
    $splitA = $line.Split(':')
    $card = $splitA[0]
    $splitB = $splitA[1].Split('|')
    $winningNums = ([regex]::Matches($splitB[0], '\d+')).Value
    $cardNums = ([regex]::Matches($splitB[1], '\d+')).Value
    $comparison = Compare-Object -ReferenceObject $winningNums -DifferenceObject $cardNums -IncludeEqual | Where-Object -Property SideIndicator -Value "==" -EQ
    "$card has $($comparison.count) matching numbers"
    if ($comparison) {
        $power = $comparison.count - 1
        $cardScore = [Math]::Pow(2, $power) 
        $pileScore += $cardScore
    }
}
$pileScore | Set-Clipboard -PassThru