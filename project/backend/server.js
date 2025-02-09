const express = require('express');
const axios = require('axios');
const cors = require('cors');  
const app = express();
const port = 5000;
const { tavily } = require("@tavily/core");

// API key for Tavily
const tvly = tavily({ apiKey: "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" });

// Middleware
app.use(cors());
app.use(express.json());

// Route for basic health check
  app.get('/health', (req, res) => {
  res.json({ message: 'Server is running!' });
});

// POST route for fact-checking
app.post('/api/fact-check', async (req, res) => {
  try {
    const { query } = req.body;
    
    // Ensure that query is present
    if (!query) {
      return res.status(400).json({ error: 'Query parameter is required' });
    }

    // Use the Tavily API to search
    const response = await tvly.search(query);

    // Return the result to the frontend
    res.json(response);

  } catch (error) {
    console.error("Error during fact-checking:", error);
    res.status(500).json({ error: 'Failed to fetch data' });
  }
});

// Start the server
app.listen(port, () => {
  console.log("Backend running on port ${port}");
});
