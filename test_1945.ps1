Set-Location -Path "d:\project sarana care\green-wall"

# Quick test: can git handle 1945 dates?
$entry = "## 1945-08-17 - Test`n"
Add-Content -Path "journal.md" -Value $entry
git add -A

$env:GIT_AUTHOR_DATE = "Thu, 17 Aug 1945 10:00:00 +0700"
$env:GIT_COMMITTER_DATE = "Thu, 17 Aug 1945 10:00:00 +0700"
git commit -m "test: 1945 date format RFC2822"
