# Development Platforms CA – News API

## Overview

This project is a REST API built with Express and TypeScript for managing news articles.

---

# Installation

Clone the repository:

```bash
git clone https://github.com/lagoracodes/development-platforms-ca.git
```

Move into the project directory:

```bash
cd development-platforms-ca
```

Install dependencies:

```bash
npm install
```

---

# Environment Variables

Create a `.env` file in the root of the project:

```env
PORT=3000
DB_HOST=localhost
DB_USER=your_user
DB_PASSWORD=your_password
DB_NAME=news
JWT_SECRET=your_secret_key
```

---

# Running the Project

Start the development server:

```bash
npm run dev
```

The server will run on:

```
http://localhost:3000
```

---

# Motivation

For me as someone who has for years been interested in all things frontend, the backend world is still quite new and at first a little intimidating. However, it’s definitely been exciting to learn about it and also made me a little bit more confident about my frontend knowledge, by helping me understand how things are being run at the backend.
I chose to do the first option for this assignment: “Build a REST API with Express with no frontend required”, by building my news API without the frontend, which might be surprising taking into account that I really enjoy working with frontend. Unfortunately, I’m going through some heavy stuff in my private life, therefore I chose the option that I felt I could realistically complete in time.
Supabase was definitely tempting because of the helpful built-in functionality that it offers (authentication, database integration, faster setup etc). However, I also know myself well enough to understand that once I started building the frontend, I would have wanted to polish the design and user experience, and risk not making it in time for the deadline. In the end, I chose the safer option, but I do not regret it, because I really enjoyed developing my own API with Express.
The part that I found a little bit challenging was working with routes, especially for articles, where I had to go over the code many times just to double check if I had written the correct method and logic for what I want to achieve (for example, post an article, edit it or edit it partially etc.).
The things that I did enjoy were related to security - I enjoyed working with authentication, implementing JWT tokens, password hashing and adding ownership checks in the route handlers so that only the article owner could update or delete their content. For me, it made the project feel more ‘real-life’ and it made me appreciate how important the security is behind every project.

---
