<#
.SYNOPSIS
This PowerShell script requests a JSON file containing information about various exercises. 
The JSON file includes exercise names, categories, and URLs for corresponding GIFs 
demonstrating each exercise.

.DESCRIPTION
The script creates a HTTP request that is then converted to JSON format. The information
is stored under response.json

.EXAMPLE
./Request-Exercises.ps1
#>

$headers=@{}
$headers.Add("X-RapidAPI-Key", "GET-API-KEY-FROM-RAPIDAPI")
$headers.Add("X-RapidAPI-Host", "exercisedb.p.rapidapi.com")
$response = Invoke-WebRequest -Uri 'https://exercisedb.p.rapidapi.com/exercises?limit=1000000' -Method GET -Headers $headers
$response.Content | ConvertFrom-JSON | ConvertTo-JSON -depth 100 | Set-Content "response.json"