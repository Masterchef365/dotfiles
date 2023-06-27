Set-PSReadlineOption -editmode vi
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
function GitNiceLog {
    git log --branches=* --graph --pretty=oneline --abbrev-commit
}

# Directory pinning (Ported by ChatGPT)
$PIN_DIR = "$HOME\.pins"

function d {
    param(
        [string]$arg1 = "",
        [string]$arg2 = ""
    )

    switch ($arg1) {
        "" {
            Get-Content -Path $PIN_DIR | ForEach-Object {
                Split-Path $_ -Leaf
            } | ForEach-Object -Begin {
                $i = 1
            } -Process {
                "{0}`t{1}" -f $i++, $_
            }
            break
        }
        "e" {
            Get-Content -Path $PIN_DIR | Select-Object -Index ($arg2 - 1)
            break
        }
        {$_ -match "^\d+$"} {
            $dir = Get-Content -Path $PIN_DIR | Select-Object -Index ($_ - 1)
            Set-Location -Path $dir
            break
        }
        "del" {
            $content = Get-Content -Path $PIN_DIR
            $content | Select-Object -Index ($arg2 - 1) -Unique | Set-Content -Path $PIN_DIR
            break
        }
        "p" {
            Get-Location | Select-Object -ExpandProperty Path | Add-Content -Path $PIN_DIR
            break
        }
    }
}
