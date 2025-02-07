require('dotenv').config();
const express = require('express');
const axios = require('axios');
const winston = require('winston');
require('winston-cloudwatch');

const app = express();
const port = process.env.PORT || 3000;

// Configure Winston CloudWatch Logging
const logger = new winston.createLogger({
  transports: [
    new winston.transports.Console(),
    new winston.transports.CloudWatch({
      logGroupName: 'WeatherAppLogs',
      logStreamName: 'WeatherAppStream',
      awsRegion: process.env.AWS_REGION || 'us-east-1',
      jsonMessage: true,
    }),
  ],
});

app.use(express.json());

// Middleware to log all incoming requests (method and endpoint)
app.use((req, res, next) => {
  logger.info(`API request received: ${req.method} ${req.originalUrl}`);
  next();
});

const apiKey = process.env.OPENWEATHER_API_KEY;

// Health Check Route
app.get('/health', (req, res) => {
  logger.info('Health check request received');
  res.json({ status: 'OK', message: 'Service is running' });
});

// Get Current Weather by City
app.get('/weather', async (req, res) => {
  const city = req.query.city || 'Budapest';
  const units = req.query.units || 'metric';

  logger.info(`Received weather request for: ${city}`);

  try {
    const response = await axios.get(
      `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=${units}`
    );

    const weatherData = response.data;

    logger.info(`Weather data fetched successfully for ${city}`, {
      city: weatherData.name,
      temperature: weatherData.main.temp,
      description: weatherData.weather[0].description,
    });

    res.json({
      city: weatherData.name,
      temperature: weatherData.main.temp,
      description: weatherData.weather[0].description,
      humidity: weatherData.main.humidity,
      pressure: weatherData.main.pressure,
    });
  } catch (error) {
    logger.error(`Error fetching weather data: ${error.message}`, { error });
    res.status(500).json({ message: 'Error fetching weather data', error: error.message });
  }
});

// 🔥 New Route: Get 7-Day Forecast
app.get('/forecast/daily', async (req, res) => {
  const city = req.query.city || 'Budapest';
  const units = req.query.units || 'metric';

  logger.info(`Received forecast request for: ${city}`);

  try {
    // Get city's latitude and longitude first
    const geoResponse = await axios.get(
      `http://api.openweathermap.org/geo/1.0/direct?q=${city}&limit=1&appid=${apiKey}`
    );

    if (!geoResponse.data.length) {
      throw new Error('City not found');
    }

    const { lat, lon } = geoResponse.data[0];

    // Fetch 7-day forecast using lat/lon
    const forecastResponse = await axios.get(
      `https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&exclude=current,minutely,hourly,alerts&units=${units}&appid=${apiKey}`
    );

    const dailyForecast = forecastResponse.data.daily.map(day => ({
      date: new Date(day.dt * 1000).toISOString().split('T')[0], // Format as YYYY-MM-DD
      temperature: {
        min: day.temp.min,
        max: day.temp.max,
      },
      description: day.weather[0].description,
      humidity: day.humidity,
      pressure: day.pressure,
    }));

    logger.info(`7-day forecast fetched successfully for ${city}`);

    res.json({
      city,
      daily_forecast: dailyForecast,
    });
  } catch (error) {
    logger.error(`Error fetching forecast data: ${error.message}`, { error });
    res.status(500).json({ message: 'Error fetching forecast data', error: error.message });
  }
});

// **New Endpoint**: List all available features
app.get('/features', (req, res) => {
  res.json({
    message: 'List of available API endpoints:',
    features: [
      { path: '/health', description: 'Check the health of the service' },
      { path: '/weather', description: 'Get current weather by city' },
      { path: '/forecast/daily', description: 'Get 7-day weather forecast' },
      // Add more features here as they are added to your app
    ],
  });
});

// Start Express Server
app.listen(port, () => {
  logger.info(`Weather app is running on port ${port} and exposed via Kubernetes Service`);
});

