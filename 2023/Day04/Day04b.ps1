$dayNum = "04"
$AoCdayPath = "./AdventOfCode/2023/Day$dayNum"

# $data = Get-Content "$($AoCdayPath)/example.txt"
$data = Get-Content "$($AoCdayPath)/input.txt"

$cardList = New-Object System.Collections.Generic.List[object]
foreach ($line in $data) {
    $splitA = $line.Split(':')
    $card = $splitA[0]
    $cardNum = ([regex]::Matches($card, '\d+')).Value

    $splitB = $splitA[1].Split('|')
    $winningNums = ([regex]::Matches($splitB[0], '\d+')).Value
    $cardNums = ([regex]::Matches($splitB[1], '\d+')).Value
    
    $equal = Compare-Object -ReferenceObject $winningNums -DifferenceObject $cardNums -IncludeEqual | Where-Object -Property SideIndicator -Value "==" -EQ
    "$card has $($equal.count) matching numbers"
    $cardList.Add(
        [PSCustomObject]@{
            cardNum    = [int]$cardNum
            matchCount = [int]$equal.count
            cardCount  = 1
        }
    )
}

$lineCount = $cardList.count
foreach ($card in $cardList) {
    $matchCount = $card.matchCount
    $cardNum = $card.cardNum
    $maxMatchCard = $cardNum + $matchCount
    #if ($maxMatchCard -ge $lineCount) { $maxMatchCard = $lineCount - 1 }
    $cardCount = $card.cardCount

    $i = $cardCount
    while ($i -gt 0) {
        $lineNum = $cardNum
        while ($lineNum -lt $maxMatchCard) {
            $cardList[$lineNum].cardCount++
            $lineNum++
        }
        $i--
    }
}

$totalCards = $cardList | Measure-Object -Sum -Property cardCount
$totalCards.Sum | Set-Clipboard -PassThru
