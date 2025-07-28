use TourismProject;

-- 📅 Query 1: Retrieve route start times
-- Returns route ID, name, estimated walking time, and scheduled start day/time
SELECT 
    Route.routeID, 
    Route.routeName, 
    Route.estimatedWalkingTime, 
    RouteStartTime.dayAndTimeStart
FROM Route
JOIN RouteStartTime ON Route.routeID = RouteStartTime.routeID;


-- 👤 Query 2: Count number of plans created per person
-- Includes users with zero plans using LEFT JOIN
-- Results are sorted from most to least plans
SELECT 
    Person.personID, 
    Person.name, 
    Person.email, 
    COUNT(Plan.planID) AS numberOfPlans
FROM Person
LEFT JOIN Plan ON Person.personID = Plan.isCreatedBy
GROUP BY Person.personID, Person.name, Person.email
ORDER BY numberOfPlans DESC;


-- 📌 Query 3: Count the number of locations from which each Point of Interest is viewable
-- Includes POIs that aren't viewable from any location
-- Results are sorted from least to most visible
SELECT 
    PointOfInterest.pointOfInterestID, 
    PointOfInterest.name, 
    PointOfInterest.typeOfPOI, 
    COUNT(ViewingInstructions.locationID) AS numberOfLocationsViewableFrom
FROM PointOfInterest
LEFT JOIN ViewingInstructions ON PointOfInterest.pointOfInterestID = ViewingInstructions.pointOfInterestID
GROUP BY PointOfInterest.pointOfInterestID, PointOfInterest.name, PointOfInterest.typeOfPOI
ORDER BY numberOfLocationsViewableFrom ASC;


-- 🧭 Query 4: List all locations for RouteID = 1 in travel order
-- Combines starting location, ordered waypoints, and ending location using UNION ALL
-- arrivalTime = 0 for start, relativeArrivalTime for waypoints, and estimatedWalkingTime for end
(
    SELECT 
        Location.locationID, 
        Location.name, 
        0 AS arrivalTime
    FROM Location
    JOIN Route ON Route.startsAt = Location.locationID
    WHERE Route.routeID = 1
)
UNION ALL
(
    SELECT 
        Location.locationID, 
        Location.name, 
        Waypoint.relativeArrivalTime AS arrivalTime
    FROM Location
    JOIN Waypoint ON Waypoint.locationID = Location.locationID
    WHERE Waypoint.routeID = 1
    ORDER BY Waypoint.relativeArrivalTime
)
UNION ALL
(
    SELECT 
        Location.locationID, 
        Location.name, 
        Route.estimatedWalkingTime AS arrivalTime
    FROM Location
    JOIN Route ON Route.endsAt = Location.locationID
    WHERE Route.routeID = 1
);




