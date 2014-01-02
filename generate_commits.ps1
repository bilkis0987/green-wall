Set-Location -Path "d:\project sarana care\green-wall"

if (Test-Path ".git") { Remove-Item -Recurse -Force .git }

git init --initial-branch=main
git config user.name "bilpas"
git config user.email "2425286.bilkis@smkn-2sbg.sch.id"

git add README.md .gitignore
$env:GIT_AUTHOR_DATE = "2024-01-01T08:00:00+07:00"
$env:GIT_COMMITTER_DATE = "2024-01-01T08:00:00+07:00"
git commit -m "chore: init daily dev journal"

# Array topik untuk variasi pesan commit
$topics = @(
    "auth", "api", "database", "frontend", "backend", "testing",
    "deployment", "docker", "ci-cd", "refactor", "bugfix", "security",
    "performance", "documentation", "styling", "responsive", "animation",
    "validation", "error-handling", "logging", "caching", "routing",
    "middleware", "hooks", "state-management", "typescript", "nextjs",
    "express", "mysql", "mongodb", "prisma", "tailwind", "react",
    "component", "layout", "navigation", "form", "upload", "search",
    "filter", "pagination", "notification", "dashboard", "profile",
    "settings", "analytics", "reporting", "export", "import", "migration"
)

$actions = @(
    "add", "update", "fix", "improve", "refactor", "implement",
    "optimize", "configure", "setup", "integrate", "create", "enhance"
)

$prefixes = @(
    "feat", "fix", "docs", "style", "refactor", "perf", "test", "chore"
)

$rand = New-Object System.Random

# Loop setiap hari di tahun 2024 (2 Jan - 31 Des)
$startDate = [DateTime]::new(2024, 1, 2)
$endDate = [DateTime]::new(2024, 12, 31)
$current = $startDate

while ($current -le $endDate) {
    # Jumlah commit per hari (1 sampai 4, acak)
    $commitsToday = $rand.Next(1, 5)

    for ($i = 0; $i -lt $commitsToday; $i++) {
        $hour = $rand.Next(8, 22)
        $minute = $rand.Next(0, 60)
        $second = $rand.Next(0, 60)

        $dateStr = $current.ToString("yyyy-MM-dd") + "T" + ("{0:D2}" -f $hour) + ":" + ("{0:D2}" -f $minute) + ":" + ("{0:D2}" -f $second) + "+07:00"

        $prefix = $prefixes[$rand.Next($prefixes.Length)]
        $topic = $topics[$rand.Next($topics.Length)]
        $action = $actions[$rand.Next($actions.Length)]

        $msg = "${prefix}(${topic}): ${action} $topic module"

        # Tulis ke journal.md agar commit tidak kosong
        $entry = "## $($current.ToString('yyyy-MM-dd')) - Entry $($i+1)`n- Topic: $topic`n- Action: $action`n`n"
        Add-Content -Path "journal.md" -Value $entry

        $env:GIT_AUTHOR_DATE = $dateStr
        $env:GIT_COMMITTER_DATE = $dateStr
        git add -A
        git commit -m $msg --quiet
    }

    $current = $current.AddDays(1)
}

Write-Host "`n===== DONE! =====" -ForegroundColor Green
Write-Host "Total days covered: 366 (full year 2024)" -ForegroundColor Cyan

git log --oneline -20
