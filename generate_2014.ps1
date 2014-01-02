Set-Location -Path "d:\project sarana care\green-wall"

$topics = @(
    "auth","api","database","frontend","backend","testing","deployment",
    "refactor","bugfix","security","performance","documentation","styling",
    "validation","error-handling","logging","caching","routing","middleware",
    "hooks","state-management","typescript","nextjs","express","mysql",
    "component","layout","navigation","form","upload","search","filter",
    "pagination","notification","dashboard","profile"
)
$actions = @("add","update","fix","improve","refactor","implement","optimize","configure","setup","integrate","create","enhance")
$prefixes = @("feat","fix","docs","style","refactor","perf","test","chore")

$rand = New-Object System.Random

$startDate = [DateTime]::new(2014, 1, 1)
$endDate   = [DateTime]::new(2014, 12, 31)
$current   = $startDate

$count = 0

while ($current -le $endDate) {
    # Exactly 2 commits per day
    for ($i = 0; $i -lt 2; $i++) {
        if ($i -eq 0) { $hour = $rand.Next(8, 14) } else { $hour = $rand.Next(14, 22) }
        $minute = $rand.Next(0, 60)
        $second = $rand.Next(0, 60)

        $dateStr = $current.ToString("yyyy-MM-dd") + "T" + ("{0:D2}" -f $hour) + ":" + ("{0:D2}" -f $minute) + ":" + ("{0:D2}" -f $second) + "+07:00"

        $prefix = $prefixes[$rand.Next($prefixes.Length)]
        $topic  = $topics[$rand.Next($topics.Length)]
        $action = $actions[$rand.Next($actions.Length)]
        $msg    = "${prefix}(${topic}): ${action} ${topic} module"

        $entry = "## $($current.ToString('yyyy-MM-dd')) - Entry $($i+1)`n- Topic: $topic`n- Action: $action`n`n"
        Add-Content -Path "journal.md" -Value $entry

        $env:GIT_AUTHOR_DATE = $dateStr
        $env:GIT_COMMITTER_DATE = $dateStr
        git add -A
        git commit --allow-empty -m $msg --quiet
        $count++
    }
    $current = $current.AddDays(1)
}

Write-Host "`n===== DONE 2014! =====" -ForegroundColor Green
Write-Host "Commits 2014 ditambahkan: $count" -ForegroundColor Cyan
$total = git rev-list --count HEAD
Write-Host "Total commits repo: $total" -ForegroundColor Cyan
