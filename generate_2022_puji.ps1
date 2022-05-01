$repoDir = "D:\gh\rusuh\green-wall"
Set-Location -Path $repoDir

git config user.name "bilpas"
git config user.email "2425286.bilkis@smkn-2sbg.sch.id"

$topics = @("auth","api","database","frontend","backend","testing","deployment","refactor","bugfix","security","performance","documentation","styling","validation","error-handling","logging","caching","routing","middleware","hooks","state-management","typescript","nextjs","express","mysql","component","layout","navigation","form","upload","search","filter","pagination","notification","dashboard","profile")
$actions = @("add","update","fix","improve","refactor","implement","optimize","configure","setup","integrate","create","enhance")
$prefixes = @("feat","fix","docs","style","refactor","perf","test","chore")

$letters = @{
    'p' = @(
        @(1,1,1,1,0),
        @(1,0,0,0,1),
        @(1,0,0,0,1),
        @(1,1,1,1,0),
        @(1,0,0,0,0),
        @(1,0,0,0,0),
        @(1,0,0,0,0)
    )
    'u' = @(
        @(1,0,0,0,1),
        @(1,0,0,0,1),
        @(1,0,0,0,1),
        @(1,0,0,0,1),
        @(1,0,0,0,1),
        @(1,0,0,0,1),
        @(0,1,1,1,0)
    )
    'j' = @(
        @(0,0,0,1,0),
        @(0,0,0,1,0),
        @(0,0,0,1,0),
        @(0,0,0,1,0),
        @(0,0,0,1,0),
        @(0,0,0,1,0),
        @(1,1,0,0,0)
    )
    'i' = @(
        @(0,0,1,0,0),
        @(0,0,0,0,0),
        @(0,0,1,0,0),
        @(0,0,1,0,0),
        @(0,0,1,0,0),
        @(0,0,1,0,0),
        @(0,0,1,0,0)
    )
}

$startDate = [DateTime]::new(2022, 5, 1)
$rand = New-Object System.Random
$totalCommits = 0

$colOffset = 0
$text = "puji"
foreach ($char in $text.ToCharArray()) {
    $pattern = $letters[[string]$char]
    for ($col = 0; $col -lt 5; $col++) {
        for ($row = 0; $row -lt 7; $row++) {
            if ($pattern[$row][$col] -eq 1) {
                $daysOffset = $row + ($colOffset + $col) * 7
                $commitDate = $startDate.AddDays($daysOffset)

                $hour = $rand.Next(8, 18)
                $minute = $rand.Next(0, 60)
                $second = $rand.Next(0, 60)
                $dateStr = "$($commitDate.ToString('yyyy-MM-dd'))T$('{0:D2}' -f $hour):$('{0:D2}' -f $minute):$('{0:D2}' -f $second)+07:00"

                $prefix = $prefixes[$rand.Next($prefixes.Length)]
                $topic  = $topics[$rand.Next($topics.Length)]
                $action = $actions[$rand.Next($actions.Length)]
                $msg = "${prefix}(${topic}): ${action} ${topic} module"

                Add-Content -Path "journal.md" -Value "## $($commitDate.ToString('yyyy-MM-dd')) [$($colOffset+$col+1)] $topic $action`n"
                $env:GIT_AUTHOR_DATE = $dateStr
                $env:GIT_COMMITTER_DATE = $dateStr
                git add -A
                git commit --allow-empty -m $msg --quiet
                $totalCommits++
            }
        }
    }
    $colOffset += 6
}

Write-Host "===== DONE =====" -ForegroundColor Green
Write-Host "Commits dibuat: $totalCommits" -ForegroundColor Cyan
