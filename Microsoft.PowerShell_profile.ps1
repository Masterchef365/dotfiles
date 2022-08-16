Set-PSReadlineOption -editmode vi
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
function GitNiceLog {
    git log --branches=* --graph --pretty=oneline --abbrev-commit
}