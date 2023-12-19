$section_pairs = Get-Content .\input.txt
#$section_pairs = Get-Content .\example_input.txt

$i = 0
foreach ($section_pair in $section_pairs) {
    $pair = $section_pair.Split(',')
    $range1 = $pair[0].split('-')
    $range2 = $pair[1].split('-')
    $section1 = ($range1[0]..$range1[1])
    $section2 = ($range2[0]..$range2[1])
    $comparison = Compare-Object $section1 $section2 -IncludeEqual | Where-Object {$_.SideIndicator -eq '=='} | Group-Object -Property SideIndicator
    if ($comparison.count -eq $section1.count -or $comparison.count -eq $section2.count) {
        Write-Verbose -Verbose -Message "Section fully-overlaps another: $section_pair"
        $i++
    }
}

Write-Verbose -Verbose -Message "Count of pairs that need to be reconsidered: $i"

$i = 0
foreach ($section_pair in $section_pairs) {
    $pair = $section_pair.Split(',')
    $range1 = $pair[0].split('-')
    $range2 = $pair[1].split('-')
    $section1 = ($range1[0]..$range1[1])
    $section2 = ($range2[0]..$range2[1])
    $comparison = Compare-Object $section1 $section2 -IncludeEqual | Where-Object {$_.SideIndicator -eq '=='}
    if ($comparison) {
        Write-Verbose -Verbose -Message "Section somewhat overlaps another: $section_pair"
        $i++
    }
}

Write-Verbose -Verbose -Message "Count of pairs that somewhat overlap: $i"