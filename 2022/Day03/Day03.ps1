$rucksacks = Get-Content .\input.txt
#$rucksacks = Get-Content .\example_input.txt

$priorities = [ordered]@{}

$lowercase = (97..(97+25)).ForEach({ [char]$_ })
$uppercase = (65..(65+25)).ForEach({ [char]$_ })
$i = 1
foreach ($item in ($lowercase + $uppercase)) {
    $priorities[$item] = $i
    $i++
}

$priority_sum = 0

foreach ($rucksack in $rucksacks) {
    $length = $rucksack.length
    $half = $length/2
    #$rucksack
    $arr1 = $rucksack.Substring(0,$half).ToCharArray()
    $arr2 = $rucksack.Substring($half,$half).ToCharArray()
    $DuplicateItem = (Compare-Object $arr1 $arr2 -IncludeEqual | Where-Object {$_.SideIndicator -eq '=='}).InputObject | Select-Object -Unique
    if ($DuplicateItem.count -eq 0) {
        "no dups"
    } else {
        $priority_sum += $priorities[$DuplicateItem]
    }
}

Write-Verbose -Verbose -Message "Sum of priorities: $priority_sum"

<#
Find the shared item between each group of three elves

#>

$i = 0
$page = 3
$total_groups = $rucksacks.count / $page

$priority_sum = 0

(0..($total_groups - 1)) | ForEach-Object {
    $group_num = $_
    $offset = $group_num * $page
    #"Group $($group_num): $($rucksacks[$offset]), $($rucksacks[$offset+1]), $($rucksacks[$offset+2])"
    
    $arr1 = $rucksacks[$offset].ToCharArray()
    $arr2 = $rucksacks[$offset+1].ToCharArray()
    $arr3 = $rucksacks[$offset+2].ToCharArray()

    $compare1 = (Compare-Object $arr1 $arr2  -IncludeEqual | Where-Object {$_.SideIndicator -eq '=='}).InputObject | Select-Object -Unique
    $DuplicateItem = (Compare-Object $compare1 $arr3  -IncludeEqual | Where-Object {$_.SideIndicator -eq '=='}).InputObject | Select-Object -Unique
    if ($DuplicateItem.count -eq 0) {
        "no dups"
    } else {
        $priority_sum += $priorities[$DuplicateItem]
    }
}

Write-Verbose -Verbose -Message "Sum of priorities: $priority_sum"
