/*
===================================================================================
DDL Script: Create Bronze Tables
===================================================================================
Script Purpose:
    This script creates tables in the "bronze" schema, dropping existing tables 
    if they already exist.
  Run this script to re-define the DDL structure of 'bronze' Tables
===================================================================================
*/

IF OBJECT_ID('bronze.calendar', 'U') IS NOT NULL
	DROP TABLE bronze.calendar;

CREATE TABLE bronze.calendar (
	date NVARCHAR(MAX),
	wm_yr_wk NVARCHAR(MAX),
	weekday NVARCHAR(MAX),
	wday NVARCHAR(MAX),
	month NVARCHAR(MAX),
	year NVARCHAR(MAX),
	day NVARCHAR(MAX),
	event_name_1 NVARCHAR(MAX),
	event_type_1 NVARCHAR(MAX),
	event_name_2 NVARCHAR(MAX),
	event_type_2 NVARCHAR(MAX),
	snap_CA NVARCHAR(MAX),
	snap_TX NVARCHAR(MAX),
	snap_WI NVARCHAR(MAX)
);

IF OBJECT_ID('bronze.sales_train_evaluation', 'U') IS NOT NULL
	DROP TABLE bronze.sales_train_evaluation;

CREATE TABLE bronze.sales_train_evaluation (
	id NVARCHAR(MAX),
	item_id NVARCHAR(MAX),
	dept_id NVARCHAR(MAX),
	cat_id NVARCHAR(MAX),
	store_id NVARCHAR(MAX),
	state_id NVARCHAR(MAX),
	d NVARCHAR(MAX),
	sales NVARCHAR(MAX)
);

IF OBJECT_ID('bronze.sales_train_validation', 'U') IS NOT NULL
	DROP TABLE bronze.sales_train_validation;

CREATE TABLE bronze.sales_train_validation (
	id NVARCHAR(MAX),
	item_id NVARCHAR(MAX),
	dept_id NVARCHAR(MAX),
	cat_id NVARCHAR(MAX),
	store_id NVARCHAR(MAX),
	d NVARCHAR(MAX),
	sales NVARCHAR(MAX)
);

IF OBJECT_ID('bronze.sell_price', 'U') IS NOT NULL
	DROP TABLE bronze.sell_price;

CREATE TABLE bronze.sell_price (
	store_id NVARCHAR(MAX),
	item_id NVARCHAR(MAX),
	wm_yr_wk NVARCHAR(MAX),
	sell_price NVARCHAR(MAX)
);
