


# Get strategy guide
$strategy = Get-Content .\input.txt

# strategy decoder
$decoder = @{
    A = @{
        Name = "Rock"
        Score = 1
    }
    B = @{
        Name = "Paper"
        Score = 2
    }
    C = @{
        Name = "Scissors"
        Score = 3
    }
    X = @{
        Name = "Rock"
        Score = 1
    }
    Y = @{
        Name = "Paper"
        Score = 2
    }
    Z = @{
        Name = "Scissors"
        Score = 3
    }
}

$moves = @{
    Rock = @{
        Paper = 0
        Rock = 3
        Scissors = 6
    }
    Paper = @{
        Scissors = 0
        Paper = 3
        Rock = 6
    }
    Scissors = @{
        Rock = 0
        Scissors = 3
        Paper = 6
    }
}

$total_score = 0
foreach ($round in $strategy) {
    $round_score = 0
    $opponent = $decoder[$round[0]]
    $me = $decoder[$round[2]]

    $round_score = $moves[$me['Name']][$opponent['Name']] + $me['Score']

    $total_score += $round_score
}

Write-Verbose -Verbose -Message "Total Score: $total_score"

<# Now X means lose, Y means draw, and Z means win.#>

$action = @{
    X = 6
    Y = 3
    Z = 0
}

$simple_move_value = @{
    Rock = 1
    Paper = 2
    Scissors = 3
}

$total_score = 0
foreach ($round in $strategy) {
    $round_score = 0
    $round = $round.split(' ')
    $opponent = $decoder[$round[0]]
    $my_action = $action[$round[1]]
    $opp_moves = $moves[$opponent['Name']]
    $my_move = $opp_moves.GetEnumerator() | Where-Object {$_.Value -eq $my_action}

    $round_score = $moves[$my_move.Name][$opponent['Name']] + $simple_move_value[$my_move.Name]

    $total_score += $round_score
}

Write-Verbose -Verbose -Message "Amended Total Score: $total_score"
