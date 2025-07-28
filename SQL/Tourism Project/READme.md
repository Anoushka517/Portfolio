# 🗺️ Route Planning and Exploration Database

This project demonstrates the design and implementation of a relational database system built to support route planning, exploration of points of interest (POIs), and user-generated walking plans.

The schema models a rich ecosystem of people, plans, walking routes, locations, and environmental points of interest — supporting detailed analytics and query-based insights.

---

## 📚 Project Description

The core goal was to take a provided Entity-Relationship Diagram (ERD) and implement the schema using SQL, populate it with meaningful data, and perform a series of queries that extract and analyze useful insights from the dataset.

The database supports:

- **People** who create and manage multiple walking **Plans**
- **Routes** which consist of starting and ending **Locations**, as well as intermediate **Waypoints**
- **Points of Interest** viewable from various locations with viewing instructions
- **Time-based Selections** of routes and locations within a plan
- **Route Start Times** and walking durations

---

## 🏗️ Schema Overview

Key entities include:

- `Person`: Users of the system
- `Plan`: Route plans created by users
- `Route`: Predefined walking routes with estimated walking time
- `Waypoint`: Intermediate stopovers along a route
- `Location`: Geographical or named positions associated with waypoints or POIs
- `PointOfInterest`: Landmarks, animals, plants, or shops visible from certain locations
- `ViewingInstructions`: Descriptions or guidelines for viewing POIs from a location
- `RouteStartTime`, `PlannedRouteSelection`, `PlannedLocationSelection`: Represent scheduled route and location selections within a plan

![Database ER Diagram](./17b574c6-f373-4940-874f-0be5406e553e.png)

---

## 🧠 SQL Queries Performed

### 1. 📅 Route Start Times

**Objective**: Retrieve start days and times for each route.

**Result**: Returns `routeID`, `routeName`, `estimatedWalkingTime`, and `dayAndTimeStart` for each route with a start schedule.

---

### 2. 👤 Number of Plans per Person

**Objective**: List each person with the number of plans they have created, including users with no plans.

**Result**: Displays `personID`, `name`, `email`, and `numberOfPlans`, sorted in descending order of plan count.

---

### 3. 📌 POI Visibility Coverage

**Objective**: Show how many locations are able to view each point of interest.

**Result**: Displays `pointOfInterestID`, `name`, `typeOfPOI`, and `numberOfLocationsViewableFrom`, sorted ascendingly.

---

### 4. 🧭 Ordered Location Sequence for a Route

**Objective**: For a given route (e.g., `routeID = 5`), list all locations in travel order.

**Technique**: Uses `UNION ALL` to combine:
- The starting location (`arrivalTime = 0`)
- Intermediate waypoints ordered by `relativeArrivalTime`
- The ending location (`arrivalTime = estimatedWalkingTime`)

**Result**: Columns include `locationID`, `name`, and derived `arrivalTime`.

---

## 🛠️ Technologies Used

- **MySQL** – schema implementation and query execution
- **SQL** – including joins, sorting, aggregations, unions, and time-based filtering
- **ER Modeling** – interpretation and implementation of database diagrams
- **GitHub** – version control and showcasing the project

---

## 🧩 Potential Applications

This database design supports apps for:

- Guided nature walks or safaris
- Zoo or botanical garden route planning
- Smart travel assistant tools
- Educational exploration systems

