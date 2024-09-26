# **ExerciseGifDownloader** 💪

## Overview

**ExerciseGifDownloader** is a collection of PowerShell scripts designed to scrape data from a RapidAPI database and create a JSON file containing data about various exercises and their corresponding GIFs. The script downloads each GIF from a provided URL, renames it based on the exercise name, and stores it in a folder corresponding to its category. This tool is ideal for fitness content creators, trainers, or anyone looking for exercise demonstration media. I originally developed the script to collect media for a larger project involving exercise demonstrations. While working on this project, I noticed a lack of free and well-organized exercise GIFs available online, so I created this tool to help download and categorize GIFs from a structured, open source dataset. 

## Features

- **Large Exercise Database:** Access to over 1300 exercises with individual exercise data.
- **Generate JSON File:** Request information regarding exercise information from the RapidAPI database.
- **Process JSON Data:** Reads the JSON file containing exercise information (name, category, and URL).
- **Download Exercise GIFs:** Automatically downloads GIFs from provided URLs.
- **Organize by Category:** Sorts and stores each downloaded GIF into its respective exercise category folder.
- **Renames Files:** Renames each downloaded GIF based on the exercise name for easy identification.
- **Error Handling:** Skips problematic entries (e.g., invalid URLs, invalid file names) and logs errors without stopping the script.

## Prerequisites

- **PowerShell 5.0** or later
- **Internet Access** to download GIFs

## Installation

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/XZE3N/ExerciseGifDownloader.git
   ```

2. Obtain a RapidAPI Private Key:
   - Visit RapidAPI and sign up for a free account or log in if you already have one.
   - In the RapidAPI dashboard, use the search bar to find the API [ExerciseDB](https://rapidapi.com/justin-WFnsXH_t6/api/exercisedb).
   - Choose a subscription plan (this API offers a free tier). Feel free to support the creator of the API - Justin.
   - After subscribing, navigate to the "Endpoints" tab for that API. At the top of the page, you’ll see your X-RapidAPI-Key. This is your private key.
   - Copy the API key and use it as a parameter when executing `Request-Exercises.ps1`.

## Usage

1. Navigate to the directory where the scripts are located.
2. Run the `Request-Exercises.ps1` PowerShell script. Remember to pass your RapidAPI private key as a parameter as such:

   ```powershell
   ./Request-Exercises.ps1 -ApiKey 'YOUR-API-KEY-FROM-RAPIDAPI'
   ```
   The script will now generate a JSON response file called `response.json`.
   
   The input JSON file should be structured as follows:
  
   ```json
   [
     {
       "bodyPart":  "waist",
       "equipment":  "body weight",
       "gifUrl":  "https://v2.exercisedb.io/image/UcvY9fRgNeiV4m",
       "id":  "0001",
       "name":  "3/4 sit-up",
       "target":  "abs",
       "secondaryMuscles":  [
         "hip flexors",
         "lower back"
       ],
       "instructions":  [
         "Lie flat on your back with your knees bent and feet flat on the ground.",
         "Place your hands behind your head with your elbows pointing outwards.",
         "Engaging your abs, slowly lift your upper body off the ground, curling forward until your torso is at a 45-degree angle.",
         "Pause for a moment at the top, then slowly lower your upper body back down to the starting position.",
         "Repeat for the desired number of repetitions."
       ]
      },
   ]
   ```
  
   - **name:** The name of the exercise (used to rename the GIF).
   - **target:** The category of the exercise (used to create a folder for organization).
   - **gifUrl:** The direct URL for downloading the GIF.
     
4. Run the `Get-Exercises.ps1` PowerShell script.
   
    ```powershell
   ./Get-Exercises.ps1
   ```

5. The script will:
   - Parse the JSON file.
   - Create folders for each exercise category (if not already present).
   - Download each GIF and rename it according to the exercise name.
   - Store the renamed GIF in its respective category folder.

## Example Output

After running the script, your directory will be organized like this:

```
categories/
├── abs/
│   ├── cable twist.gif
├── biceps/
│   ├── barbell curl.gif
```

## Error Handling

- **Invalid URLs:** The script logs any invalid URLs and skips those entries without stopping execution.
- **Invalid File Names:** If a GIF name contains invalid characters, they are removed or replaced with valid ones.

## Roadmap

Future enhancements could include:
- Adding multi-threading for faster downloads.
- CLI options for specifying output directories.
- Enhanced logging and reporting capabilities.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you'd like to help improve this project.

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## Contact

If you have any questions or suggestions, feel free to reach out to me at:  
**Email:** xze3n.py@gmail.com  
Or open an issue in the GitHub repository.
