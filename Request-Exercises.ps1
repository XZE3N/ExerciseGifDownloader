<#
.SYNOPSIS
This PowerShell script requests a JSON file containing information about various exercises. 
The JSON file includes exercise names, categories, and URLs for corresponding GIFs 
demonstrating each exercise.

.DESCRIPTION
The script creates a HTTP request that is then converted to JSON format. The information
is stored under response.json.

.PARAMETER ApiKey
Specifies the RapidAPI Key.

.EXAMPLE
./Request-Exercises.ps1 -ApiKey 'YOUR-API-KEY-FROM-RAPIDAPI'
#>

Param(
    [string]$ApiKey,  # RapidAPI Key passed as a parameter
)

# Check if the API key is provided
if (-not $ApiKey) {
    Write-Host "Error: API key is required. Please specify the API key using the -ApiKey parameter."
    exit 1
}

$headers=@{}
$headers.Add("X-RapidAPI-Key", $ApiKey)
$headers.Add("X-RapidAPI-Host", "exercisedb.p.rapidapi.com")
$response = Invoke-WebRequest -Uri 'https://exercisedb.p.rapidapi.com/exercises?limit=1000000' -Method GET -Headers $headers
$response.Content | ConvertFrom-JSON | ConvertTo-JSON -depth 100 | Set-Content "response.json"
