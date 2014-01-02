Set-Location -Path "d:\project sarana care\green-wall"

# Remove old journal, start fresh
if (Test-Path "journal.md") { Remove-Item "journal.md" }

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

# ===== INITIAL COMMIT =====
git add README.md .gitignore
$env:GIT_AUTHOR_DATE = "2014-01-01T08:00:00+07:00"
$env:GIT_COMMITTER_DATE = "2014-01-01T08:00:00+07:00"
git commit -m "chore: init daily dev journal"

# ===== 2014: 2 commits/day =====
Write-Host "Generating 2014..." -ForegroundColor Yellow
$startDate = [DateTime]::new(2014, 1, 2)
$endDate   = [DateTime]::new(2014, 12, 31)
$current   = $startDate

while ($current -le $endDate) {
    for ($i = 0; $i -lt 2; $i++) {
        if ($i -eq 0) { $hour = $rand.Next(8, 14) } else { $hour = $rand.Next(14, 22) }
        $minute = $rand.Next(0, 60); $second = $rand.Next(0, 60)
        $dateStr = $current.ToString("yyyy-MM-dd") + "T" + ("{0:D2}" -f $hour) + ":" + ("{0:D2}" -f $minute) + ":" + ("{0:D2}" -f $second) + "+07:00"

        $prefix = $prefixes[$rand.Next($prefixes.Length)]
        $topic  = $topics[$rand.Next($topics.Length)]
        $action = $actions[$rand.Next($actions.Length)]

        Add-Content -Path "journal.md" -Value "## $($current.ToString('yyyy-MM-dd')) [$($i+1)] $topic $action`n"
        $env:GIT_AUTHOR_DATE = $dateStr; $env:GIT_COMMITTER_DATE = $dateStr
        git add -A; git commit --allow-empty -m "${prefix}(${topic}): ${action} ${topic} module" --quiet
    }
    $current = $current.AddDays(1)
}
Write-Host "2014 done!" -ForegroundColor Green

# ===== 2024: 1-4 commits/day =====
Write-Host "Generating 2024..." -ForegroundColor Yellow
$startDate = [DateTime]::new(2024, 1, 1)
$endDate   = [DateTime]::new(2024, 12, 31)
$current   = $startDate

while ($current -le $endDate) {
    $commitsToday = $rand.Next(1, 5)
    for ($i = 0; $i -lt $commitsToday; $i++) {
        $hour = $rand.Next(8, 22); $minute = $rand.Next(0, 60); $second = $rand.Next(0, 60)
        $dateStr = $current.ToString("yyyy-MM-dd") + "T" + ("{0:D2}" -f $hour) + ":" + ("{0:D2}" -f $minute) + ":" + ("{0:D2}" -f $second) + "+07:00"

        $prefix = $prefixes[$rand.Next($prefixes.Length)]
        $topic  = $topics[$rand.Next($topics.Length)]
        $action = $actions[$rand.Next($actions.Length)]

        Add-Content -Path "journal.md" -Value "## $($current.ToString('yyyy-MM-dd')) [$($i+1)] $topic $action`n"
        $env:GIT_AUTHOR_DATE = $dateStr; $env:GIT_COMMITTER_DATE = $dateStr
        git add -A; git commit --allow-empty -m "${prefix}(${topic}): ${action} ${topic} module" --quiet
    }
    $current = $current.AddDays(1)
}
Write-Host "2024 done!" -ForegroundColor Green

$total = git rev-list --count HEAD
Write-Host "`n===== ALL DONE! Total commits: $total =====" -ForegroundColor Cyan
