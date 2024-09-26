<#
.SYNOPSIS
This PowerShell script processes a JSON file containing information about various exercises. 
The JSON file includes exercise names, categories, and URLs for corresponding GIFs 
demonstrating each exercise.

.DESCRIPTION
The script downloads the GIF files, renames them according to the exercise names, and stores 
them in category-specific folders. Each folder corresponds to a specific exercise category 
(e.g., "abs", "biceps", etc.), creating an organized structure for easy reference.

.EXAMPLE
./Get-Exercises.ps1
#>

# Read the JSON file
$jsonContent = Get-Content -Path "response.json" -Raw

# Convert JSON content to PowerShell object
$jsonObject = $jsonContent | ConvertFrom-Json

# Create the all GIFs folder if it doesn't exist
$allFolderPath = "all"
if (-not (Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
}

# Create the categories folder if it doesn't exist
$parentFolderPath = "categories"
if (-not (Test-Path -Path $parentFolderPath)) {
    New-Item -Path $parentFolderPath -ItemType Directory
}

# Iterate through each exercise in the "value" array
foreach ($exercise in $jsonObject.value) {
    # Extract name and gifUrl for each exercise
    $exerciseName = $exercise.name
    $exerciseGifUrl = $exercise.gifUrl
    $exerciseTarget = $exercise.target
    $exerciseBodyPart = $exercise.bodyPart
    $exerciseSecondaryMuscles = $exercise.secondaryMuscles
    $exerciseEquipment = $exercise.equipment
    $exerciseInstructions = $exercise.instructions
    
    # Remove invalid characters and format the name for a file name
    $formattedFileName = $exerciseName -replace '[\\\/\:\*\?\"\<\>\|]', ''
    $formattedFileName = $formattedFileName -replace '\s+', ' ' -replace '\s+$', ''
    
    # Output the formatted file name and gifUrl
    Write-Host "Formatted File Name: $formattedFileName"
    Write-Host "Target: $exerciseTarget"
    Write-Host "GIF URL: $exerciseGifUrl"

    # Create subfolder for the category if it doesn't exist
    $categoryFolderPath = Join-Path -Path $parentFolderPath -ChildPath $exerciseTarget
    if (-not (Test-Path -Path $categoryFolderPath)) {
        New-Item -Path $categoryFolderPath -ItemType Directory
    }

    # Download the GIF file
    $gifFilePath = Join-Path -Path $categoryFolderPath -ChildPath "$formattedFileName.gif"
    if (-not (Test-Path -Path $gifFilePath)) {
        Invoke-WebRequest -Uri $exerciseGifUrl -OutFile $gifFilePath
        Write-Host "GIF file downloaded and saved in category folder: $gifFilePath"
    } else {
        Write-Host "GIF file already exists in category folder: $gifFilePath"
    }
    
    # Copy the GIF file to the "all" folder if it doesn't exist there
    $allGifFilePath = Join-Path -Path $allFolderPath -ChildPath "$formattedFileName.gif"
    if (-not (Test-Path -Path $allGifFilePath)) {
        Copy-Item -Path $gifFilePath -Destination $allFolderPath
        Write-Host "GIF file copied to 'all' folder: $allGifFilePath"
    } else {
        Write-Host "GIF file already exists in 'all' folder: $allGifFilePath"
    }
}