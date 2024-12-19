# Get input
$inputFile = ".\sampleinput1.txt"
$inputFile = ".\input1.txt"
$data = Get-Content -Path $inputFile

# Convert into two arrays
$leftList = @()
$rightList = @()
foreach ($line in $data) {
    $split = $line.Split('   ')
    $leftList += $split[0]
    $rightList += $split[1]
}

# Part 1

# Sort both lists
$sortedLeftList = $leftList | Sort-Object
$sortedRightList = $rightList | Sort-Object

# Calculate the total distance
$totalDistance = 0
for ($i = 0; $i -lt $sortedLeftList.Length; $i++) {
    $distance = [math]::Abs($sortedLeftList[$i] - $sortedRightList[$i])
    $totalDistance += $distance
}

# Output the total distance
Write-Output $totalDistance

# Part Two

# Create a hashtable to count occurrences in the right list
$rightListCount = @{}
foreach ($number in $rightList) {
    if (-not $rightListCount.ContainsKey($number)) {
        $rightListCount[$number] = 0
    }
    $rightListCount[$number]++
}

# Calculate the similarity score
[int]$similarityScore = 0
foreach ($number in $leftList) {
    if ($rightListCount.ContainsKey($number)) {
        $similarityScore += [int]$number * [int]$rightListCount[$number]
    }
}

# Output the similarity score
Write-Output $similarityScore