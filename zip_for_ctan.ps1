
# replace windows (CRLF) with unix (LF) line endings 
# copy needed files and compressing to zip file

$inList = ".\README.md", ".\rest-api.dtx", ".\rest-api.ins"
$pdfFile = ".\rest-api.pdf"

$folder = "..\rest-api"
$zipFile = "..\rest-api.zip"

$encode = "UTF8"

# delete temp folder and zip
if (Test-Path $zipFile) { Remove-Item $zipFile; }
if (Test-Path $folder) { Remove-Item $folder -Recurse; }

# create temp folder
New-Item -Path $folder -ItemType Directory

# copy files and replace line endings
foreach ($in in $inList) 
{
    ((Get-Content $in -Encoding $encode) -join "`n") + "`n" | Set-Content -NoNewline -Encoding $encode ($folder + $in)
}

# copy pdf file
Copy-Item $pdfFile -Destination ($folder + $pdfFile)

# compressing folder, create zip file
Compress-Archive -LiteralPath $folder -DestinationPath $zipFile

# delete temp folder
if (Test-Path $folder) { Remove-Item $folder -Recurse; }