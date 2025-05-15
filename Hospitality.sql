create database hospitality;
use hospitality;

select * from dim_date;
select * from dim_hotels;
select * from dim_rooms;
select * from fact_aggregated_bookings;
select * from fact_bookings;


--  Total Revenue --
select concat(round(sum(revenue_realized)/1000000000, 2), 'b') as Total_Revenue
from fact_bookings;

-- Occupancy --
select concat(round(sum(successful_bookings)/sum(capacity) *100,2),'%') as Occupancy
from fact_aggregated_bookings;

-- Cancellation Rate --
select concat(round(sum(case when booking_status = "Cancelled" then 1 end) / count(booking_id) *100 ,0),'%') as Cancellation_Rate
from fact_bookings;

-- Total Booking --
select concat(round(count(booking_id)/1000,0),'k') as Total_Bookings
from fact_bookings;

-- Utilize capacity --
select concat(round(sum(capacity)/1000,0),'k')
from fact_aggregated_bookings;

-- Trend Analysis --
select monthname(booking_date) as Month, concat(round(sum(revenue_realized)/1000000,0),'M') as Reveune
from fact_bookings
group by monthname(booking_date);

-- Weekday  & Weekend  Revenue and Booking --
select d.day_type , count(f.booking_id) as Total_Booking, sum(f.revenue_realized) as Total_Revenue
from dim_date d inner join fact_bookings f
on d.date = f.booking_date
group by d.day_type;

-- Revenue by City --
select h.city, concat(round(sum(f.revenue_realized)/1000000,0),'M') as revenue
from dim_hotels h inner join fact_bookings f
on h.property_id = f.property_id
group by city
order by revenue desc;


-- Class Wise Revenue --
select r.room_class, concat(round(sum(f.revenue_realized)/1000000,0),'M') as Revenue
from dim_rooms r inner join fact_bookings f
on r.room_id = f.room_category
group by r.room_class
order by revenue desc;

-- Checked out cancel No show --
select booking_status, count(booking_id)
from fact_bookings
group by booking_status;


-- Weekly trend Key trend --
select d.week_no, count(f.booking_id) as Total_Booking,sum(f.revenue_realized) as Total_Revenue
from dim_date d join fact_bookings f
on d.date = f.booking_date
group by d.week_no
order by d.week_no;




