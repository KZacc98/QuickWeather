<div style="text-align: center;">
  <img src="https://github.com/KZacc98/QuickWeather/blob/main/QuickWeather/Resources/Assets.xcassets/AppIcon.appiconset/appIcon.png" alt="App icon" width="300" height="300" style="border-radius: 50px;">
</div>

# Quick Weather
# DISCLAMER
```
In order for app to work you'll have to provide your own API key in: WeatherWorker on line 12
you can get one here: [OpenWeatherMap API](https://openweathermap.org/api)

```
## Project Overview

The objective of this project was to design and develop a user-friendly weather application.
The app utilizes the [OpenWeatherMap API](https://openweathermap.org/api) to provide accurate and up-to-date weather information.
Users can search for their city to view current weather conditions, with details varying based on the data returned by the API.

Additionally, users can access future weather forecasts, offering up to 32 data points in 3-hour increments, if available.
The application provides detailed weather information, including:

- **Temperature**
- **Feels-like temperature**
- **Humidity**
- **Atmospheric pressure**

# App Demos
## Home
| **First Open**   | **Open with saved cities**   |
|-----------------|----------------------|
| <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724963740/QWDemos/home.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724964241/QWDemos/homeSubsequent.png" width="300" /> |

#### Textfield Validation
The text field is validated using a regular expression with the following conditions:

- It should not accept numbers.
- It should not accept special characters.
- It should support Polish characters.

Additionally, the text field must not be empty when the return key is pressed and an API call is triggered.

| **Numbers**   | **Special characters**   | **Polish characters**   | **Empty**   |
|-----------------|----------------------|----------------------|----------------------|
| <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724964027/QWDemos/validationNumber.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724964622/QWDemos/specialChars.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724964049/QWDemos/polishChars.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724964057/QWDemos/fieldEmpty.png" width="300" /> |

## Weather Details
| **Weather Details**   | **Additional Data**   |
|-----------------|----------------------|
| <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724967493/QWDemos/weatherDetails.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724967564/QWDemos/additionalDetails.png" width="300" /> |

Additional weather data, as described in the project overview, is available. This is indicated by an info icon in the top right corner of a cell.

For presentation purposes, when the user taps on a cell without the info icon in the top right corner (without additional data), they can change the app's color scheme. Normally, the color scheme is dependent on the time of day, as shown in the UI variant below.
| **Dawn (6:00-8:00)**   | **Day (9:00-16:00)**   | **Dusk (17:00-19:00)**   | **Night (20:00-6:00)**   |
|-----------------|----------------------|----------------------|----------------------|
| <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724967945/QWDemos/dawn.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724967965/QWDemos/day.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724967981/QWDemos/dusk.png" width="300" /> | <img src="https://res.cloudinary.com/dv1dmymg2/image/upload/v1724967493/QWDemos/weatherDetails.png" width="300" /> |


## License

Proprietary License

Copyright 2024 KZacc98

All rights reserved.

This source code is licensed exclusively for viewing purposes and cannot be used(Excluding demonstration purposes), copied(Excluding cloning for viewing purposes), modified(excluding WeatherWorker), or distributed without the explicit written permission of the author.
