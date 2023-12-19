<#
The Elves take turns writing down the number of Calories contained by the various meals, snacks, rations, etc. that they've brought with them, one item per line. Each Elf separates their own inventory from the previous Elf's inventory (if any) by a blank line.

Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?

#>

$elf_inventory_input = Get-Content .\input.txt

<#
Build an array of elves. Each array item is another array containing the items carried by that elf

$elf_inventory
{
    elf_num = 1
    item = (7532,37124)
    total_cal = 44656
},
{
    elf_num = 2
    item = (37309)
    total_cal = 37309
}

#>

#Find blanks
#$elf_inventory_input | where-object {$_ -eq ""}

$elf_inventory = @()

$i = 1
$elf_backpack = @()
$total_cal = 0

foreach ($item in $elf_inventory_input) {
    $elf_num = $1

    if ($item -ne "") {
        $elf_backpack += $item
        $total_cal += $item
    } else {
        #build elf object
        $obj = [PSCustomObject]@{
            elf_num = $i
            elf_backpack = $elf_backpack
            total_cal = $total_cal
        }
        $elf_inventory += $obj
        # get ready for next elf
        $i++
        $elf_backpack = @()
        $total_cal = 0
    }

}

$elf_inventory

$stats = $elf_inventory | Measure-Object -maximum -property total_cal

Write-Verbose -verbose -Message "Largest total calories carried by an elf is $($stats.maximum)"

<#
What's the total calories for the top three elves by total cals?
#>

$sum = (($elf_inventory | Sort-object -property total_cal -descending | Select-Object -first 3).total_cal | Measure-Object -sum).sum 

Write-Verbose -verbose -Message "Sum of total calories carried by top three elf is $sum"