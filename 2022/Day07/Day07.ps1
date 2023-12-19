$data = Get-Content .\input.txt
#$data = Get-Content .\example_input.txt

<# 
- / (dir)
  - a (dir)
    - e (dir)
      - i (file, size=584)
    - f (file, size=29116)
    - g (file, size=2557)
    - h.lst (file, size=62596)
  - b.txt (file, size=14848514)
  - c.dat (file, size=8504156)
  - d (dir)
    - j (file, size=4060174)
    - d.log (file, size=8033020)
    - d.ext (file, size=5626152)
    - k (file, size=7214296)


#>


$filesystem = @{
    name     = '/'
    type     = 'dir'
    size     = 0
    contents = @(
        @{
            name     = 'a'
            type     = 'dir'
            size     = 0
            contents = @(
                @{
                    name     = 'e'
                    type     = 'dir'
                    size     = 0
                    contents = @(
                        @{
                            name = 'i'
                            type = 'file'
                            size = 584
                        }
                    )
                },
                @{
                    name = 'f'
                    type = 'file'
                    size = 29116
                },
                @{
                    name = 'g'
                    type = 'file'
                    size = 2557
                },
                @{
                    name = 'h.lst'
                    type = 'file'
                    size = 62596
                }
            )
        },
        @{
            name = 'b.txt'
            type = 'file'
            size = 14848514
        },
        @{
            name = 'c.dat'
            type = 'file'
            size = 8504156
        },
        @{
            name     = 'd'
            type     = 'dir'
            size     = 0
            contents = @(
                @{
                    name = 'j'
                    type = 'file'
                    size = 4060174
                },
                @{
                    name = 'd.log'
                    type = 'file'
                    size = 8033020
                },
                @{
                    name = 'd.ext'
                    type = 'file'
                    size = 5626152
                },
                @{
                    name = 'k'
                    type = 'file'
                    size = 7214296
                }
            )
        }
    )
}

$level = 0 # root
$itemNum = 0
$dir = $filesystem.item('contents')[$level]
do {
    $currentDir = $dir.item('contents')
    if ($dir.Count)
    
    $item = $currentDir[$itemNum]
    if ($item.item('type') -eq 'dir') {
        # go deeper
    }
    else {
        $item.item('size')
        $currentDir.item('size') = $currentDir.item('size') + $item.item('size')
    }
    $itemNum++
} until ($level -eq 0)