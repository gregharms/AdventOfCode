$data = Get-Content .\input.txt
#$data = Get-Content .\example_input.txt

#find row of empty 
$divider = 0
foreach ($line in $data) {
    if ($line -eq '') {
        break
    } else {
        $divider++
    }
}
$divider

$stack_input = $data[0..($divider-2)]
$move_input = $data[($divider+1)..($data.count - 1)]
$stack_width = $stack_input[0].ToCharArray().count
$stack_num = ($stack_width + 1) / 4

# ready the ship$
$ship = [ordered]@{}
$i = 1
do {
    $stack = New-Object System.Collections.Stack 
    $ship.Add("stack$i",$stack)
    $i++
}
until ($i -gt $stack_num)

#load the ship
[array]::Reverse($stack_input)
foreach ($item in $stack_input) {
    $i = 1
    $j = 1
    $item = $item.ToCharArray()
    do {
        $crate = $item[$i]
        if ($crate -match '\w') {
            $stack_key = "stack$j"
            $ship[$stack_key].push($crate)
    }
    $i = $i + 4
    $j++
    } until ($i -gt $stack_num*4)
}

# Ship is loaded. Now process the moves.

foreach ($line in $move_input) {
    $arr = $line.Split(' ')
    $crate_move_count = $arr[1]
    $source_stack_num = $arr[3]
    $target_stack_num = $arr[5]
    do {
        $ship["stack$target_stack_num"].Push($ship["stack$source_stack_num"].Pop())
        $crate_move_count = $crate_move_count - 1
    } until ($crate_move_count -eq 0)
}

$top_crates = foreach ($key in $ship.Keys) {
    $ship[$key].Peek()
}

Write-Verbose -verbose -message "Message: $($top_crates -join '')"

#Crane 9001 - Moves crate count all at once

$data = Get-Content .\input.txt
#$data = Get-Content .\example_input.txt

#find row of empty 
$divider = 0
foreach ($line in $data) {
    if ($line -eq '') {
        break
    } else {
        $divider++
    }
}
$divider

$stack_input = $data[0..($divider-2)]
$move_input = $data[($divider+1)..($data.count - 1)]
$stack_width = $stack_input[0].ToCharArray().count
$stack_num = ($stack_width + 1) / 4

# ready the ship$
$ship = [ordered]@{}
$i = 1
do {
    $stack = New-Object System.Collections.Stack 
    $ship.Add("stack$i",$stack)
    $i++
}
until ($i -gt $stack_num)

#load the ship
[array]::Reverse($stack_input)
foreach ($item in $stack_input) {
    $i = 1
    $j = 1
    $item = $item.ToCharArray()
    do {
        $crate = $item[$i]
        if ($crate -match '\w') {
            $stack_key = "stack$j"
            $ship[$stack_key].push($crate)
    }
    $i = $i + 4
    $j++
    } until ($i -gt $stack_num*4)
}

# Ship is loaded. Now process the moves.

foreach ($line in $move_input) {
    $arr = $line.Split(' ')
    $crate_move_count = $arr[1]
    $source_stack_num = $arr[3]
    $target_stack_num = $arr[5]
    $temp_stack = New-Object System.Collections.Stack 
    $i = $crate_move_count
    #move to temp stack
    do {
        $temp_stack.Push($ship["stack$source_stack_num"].Pop())
        $i = $i - 1
    } until ($i -eq 0)
    #move from temp stack
    do {
        $ship["stack$target_stack_num"].Push($temp_stack.Pop())
        $crate_move_count = $crate_move_count - 1
    } until ($crate_move_count -eq 0)
}

$top_crates = foreach ($key in $ship.Keys) {
    $ship[$key].Peek()
}

Write-Verbose -verbose -message "Message: $($top_crates -join '')"
