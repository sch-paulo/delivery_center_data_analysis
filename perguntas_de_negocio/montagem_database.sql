CREATE DATABASE delivery_center;
USE delivery_center;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS channels;
DROP TABLE IF EXISTS deliveries;
DROP TABLE IF EXISTS drivers;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS hubs;

CREATE TABLE channels (
    channel_id INT PRIMARY KEY,
    channel_name VARCHAR(50),
    channel_type VARCHAR(50)
);

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_modal VARCHAR(50),
    driver_type VARCHAR(50)
);

CREATE TABLE deliveries (
    delivery_id INT PRIMARY KEY,
    delivery_order_id INT,
    driver_id INT NULL,
    delivery_distance_meters DECIMAL(10, 2),
    delivery_status VARCHAR(50)
);

CREATE TABLE hubs (
    hub_id INT PRIMARY KEY,
    hub_name VARCHAR(50),
    hub_city VARCHAR(50),
    hub_state CHAR(2),
    hub_latitude DECIMAL(9, 6),
    hub_longitude DECIMAL(9, 6)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    payment_order_id INT,
    payment_amount DECIMAL(10, 2),
    payment_fee DECIMAL(10, 2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50)
);

CREATE TABLE stores (
    store_id INT PRIMARY KEY,
    hub_id INT,
    store_name VARCHAR(50),
    store_segment VARCHAR(50),
    store_plan_price DECIMAL(10, 2),
    store_latitude DECIMAL(9, 6),
    store_longitude DECIMAL(9, 6)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    store_id INT,
    channel_id INT,
    payment_order_id INT,
    delivery_order_id INT,
    order_status VARCHAR(50),
    order_amount DECIMAL(10, 2),
    order_delivery_fee DECIMAL(10, 2),
    order_delivery_cost DECIMAL(10, 2),
    order_created_hour INT,
    order_created_minute INT,
    order_created_day INT,
    order_created_month INT,
    order_created_year INT,
    order_moment_created DATETIME,
    order_moment_accepted DATETIME,
    order_moment_ready DATETIME,
    order_moment_collected DATETIME,
    order_moment_in_expedition DATETIME,
    order_moment_delivering DATETIME,
    order_moment_delivered DATETIME,
    order_moment_finished DATETIME,
    order_metric_collected_time DECIMAL(10, 2),
    order_metric_paused_time DECIMAL(10, 2),
    order_metric_production_time DECIMAL(10, 2),
    order_metric_walking_time DECIMAL(10, 2),
    order_metric_expediton_speed_time DECIMAL(10, 2),
    order_metric_transit_time DECIMAL(10, 2),
    order_metric_cycle_time DECIMAL(10, 2)
);


ALTER TABLE deliveries
MODIFY COLUMN driver_id INT NULL;
