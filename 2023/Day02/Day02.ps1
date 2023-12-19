$minimumBagContents = @{
    red   = 12
    green = 13
    blue  = 14
}

# $data = Get-Content ./AdventOfCode2023/Day02/example1.txt
$data = Get-Content ./AdventOfCode2023/Day02/input.txt

#$games = New-Object Object[] $data.Length

$gameIDTotal = 0
foreach ($game in $data) {
    $validGame = $true
    $firstSplit = $game.Split(':')
    $gameID = $firstSplit[0].Split(' ')[1]
    $handfuls = $firstSplit[1].Split(';')
    foreach ($handful in $handfuls) {
        $cubeColorCount = $handful.Split(',').trim()

        #Validity Test
        foreach ($cube in $cubeColorCount) {
            $cubeSplit = $cube.Split(' ')
            $color = $cubeSplit[1]
            $count = [int]$cubeSplit[0]
            if ($count -gt $minimumBagContents.item($color)) {
                $validGame = $false
            }
        }
    }
    if ($validGame) {
        $gameIDTotal += $gameID
    }
}

Write-Output "Total Game ID: $gameIDTotal"


# $data = Get-Content ./AdventOfCode2023/Day02/example1.txt
$data = Get-Content ./AdventOfCode2023/Day02/input.txt

$gameIDTotal = 0
foreach ($game in $data) {
    $maximums = @{
        red   = 0
        blue  = 0
        green = 0
    }
    $firstSplit = $game.Split(':')
    $gameID = $firstSplit[0].Split(' ')[1]
    $handfuls = $firstSplit[1].Split(';')
    foreach ($handful in $handfuls) {
        $cubeColorCount = $handful.Split(',').trim()
        #Validity Test
        foreach ($cube in $cubeColorCount) {
            $cubeSplit = $cube.Split(' ')
            $color = $cubeSplit[1]
            $count = [int]$cubeSplit[0]
            if ($count -gt $maximums.item($color)) {
                $maximums.item($color) = $count
            }
        }
    }
    $gameIDTotal += $maximums.item("red") * $maximums.item("blue") * $maximums.item("green") 
}

Write-Output "Total Game ID: $gameIDTotal"

