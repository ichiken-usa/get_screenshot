# From https://stackoverflow.com/questions/2969321/how-can-i-do-a-screen-capture-in-windows-powershell
Add-Type -AssemblyName System.Windows.Forms,System.Drawing

# Make date folder
$date = Get-Date -Format "yyyyMMdd"
$SaveDir = "Data\" + $date
if (Test-Path .\$SaveDir) {
    Write-Host "Already existed"
} else {
    mkdir .\$SaveDir
}

# Get full screen size
$screens = [Windows.Forms.Screen]::AllScreens

$top    = ($screens.Bounds.Top    | Measure-Object -Minimum).Minimum
$left   = ($screens.Bounds.Left   | Measure-Object -Minimum).Minimum
$width  = ($screens.Bounds.Right  | Measure-Object -Maximum).Maximum
$height = ($screens.Bounds.Bottom | Measure-Object -Maximum).Maximum

# Take screenshot
$bounds   = [Drawing.Rectangle]::FromLTRB($left, $top, $width, $height)
$bmp      = New-Object System.Drawing.Bitmap ([int]$bounds.width), ([int]$bounds.height)
$graphics = [Drawing.Graphics]::FromImage($bmp)
$graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)

# Datetime format for filename
$DateTime = Get-Date -Format "yyyyMMdd_HHmmss"

# Full path for file
[string]$SaveFullPath = join-path $SaveDir "$DateTime.$Format"
$SaveFullPath += "bmp"
Write-Host $SaveFullPath

# Output
$bmp.Save($SaveFullPath)

# 
$graphics.Dispose()
$bmp.Dispose()