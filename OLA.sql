create database ola;
use ola ;
# Retrieve all successful bookings:
SELECT * FROM bookings WHERE Booking_Status = 'Success';

# Find the average ride distance for each vehicle type:
SELECT Vehicle_Type, AVG(Ride_Distance) as avg_distance FROM bookings GROUP BY
Vehicle_Type;

#  Get the total number of cancelled rides by customers:
SELECT COUNT(*) FROM bookings WHERE Booking_Status = 'canceled by Customer';
SELECT COUNT(*) FROM bookings WHERE Booking_Status = 'canceled by Driver';


# List the top 5 customers who booked the highest number of rides:
SELECT Customer_ID, COUNT(Booking_ID) as total_rides FROM bookings GROUP BY
Customer_ID ORDER BY total_rides DESC LIMIT 5;

# Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT COUNT(*) FROM bookings WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue'	;

# Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT MAX(Driver_Ratings) as max_rating, MIN(Driver_Ratings) as min_rating FROM
bookings WHERE Vehicle_Type = 'Prime Sedan';

# Retrieve all rides where payment was made using UPI:

SELECT * FROM bookings WHERE Payment_Method = 'UPI';
# Find the average customer rating per vehicle type:
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating FROM bookings
GROUP BY Vehicle_Type;

# Calculate the total booking value of rides completed successfully:
SELECT SUM(Booking_Value) as total_successful_value FROM bookings WHERE
Booking_Status = 'Success';


# List all incomplete rides along with the reason:
SELECT Booking_ID, Incomplete_Rides_Reason FROM bookings WHERE Incomplete_Rides =
'Yes';

#Detect unusual drop-off delays (C_TAT > V_TAT by more than 15%)
SELECT Booking_ID, V_TAT, C_TAT,
       ROUND(((C_TAT - V_TAT) * 100.0) / V_TAT, 2) AS Delay_Percentage
FROM bookings
WHERE C_TAT > V_TAT * 1.15;


#Find underperforming locations (low rating + high incomplete rides)
SELECT Pickup_Location,
       ROUND(AVG(Customer_Rating), 2) AS Avg_Rating,
       SUM(Incomplete_Rides) AS Total_Incomplete
FROM bookings
GROUP BY Pickup_Location
HAVING AVG(Customer_Rating) < 3.0 AND SUM(Incomplete_Rides) > 5
ORDER BY Total_Incomplete DESC;

#Which payment method generates highest revenue?
SELECT Payment_Method, 
       COUNT(*) AS Total_Transactions,
       SUM(Booking_Value) AS Total_Revenue
FROM bookings
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

#Ride demand by hour of the day
SELECT EXTRACT(HOUR FROM Time) AS Ride_Hour,
       COUNT(*) AS Total_Rides
FROM bookings
GROUP BY EXTRACT(HOUR FROM Time)
ORDER BY Total_Rides DESC;



# Vehicle type efficiency: ride distance per rating unit
SELECT Vehicle_Type,
       ROUND(SUM(Ride_Distance) / NULLIF(SUM(Customer_Rating), 0), 2) AS Distance_Per_Rating_Unit
FROM bookings
GROUP BY Vehicle_Type
ORDER BY Distance_Per_Rating_Unit DESC;


#Top 5 incomplete ride reasons and how often they occur
SELECT Incomplete_Rides_Reason, COUNT(*) AS Occurrence
FROM bookings
WHERE Incomplete_Rides = 1
GROUP BY Incomplete_Rides_Reason
ORDER BY Occurrence DESC
LIMIT 10;













