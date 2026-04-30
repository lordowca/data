/*
================================================================================
    ToyStore Data Warehouse Initialization Script
================================================================================
    Purpose: Initialize the ToyStoreDW database with a three-layer schema 
             architecture (bronze, silver, gold) following data warehouse 
             best practices.
    
    Author: G.B. Team
    Created: 2026-04-07
================================================================================
*/

-- Switch to the master database context
USE master;
GO

-- ============================================================================
-- DROP AND RECREATE DATABASE
-- ============================================================================
-- Drop the existing 'ToyStoreDW' database if it exists
-- This ensures a clean initialization by removing any previous data and objects
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ToyStoreDW')
BEGIN
    -- Set database to single-user mode to terminate existing connections
    ALTER DATABASE ToyStoreDW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    -- Drop the entire database
    DROP DATABASE ToyStoreDW;
END;
GO

-- Create a fresh ToyStoreDW database
CREATE DATABASE ToyStoreDW;
GO

-- ============================================================================
-- SWITCH TO NEW DATABASE AND CREATE SCHEMAS
-- ============================================================================
-- Switch context to the newly created ToyStoreDW database
USE ToyStoreDW;
GO

-- Create BRONZE schema
-- Purpose: Raw data layer - contains unmodified data imported from source systems
CREATE SCHEMA bronze;
GO  

-- Create SILVER schema
-- Purpose: Cleaned and standardized data layer - implements data quality rules,
--          deduplication, and data type standardization
CREATE SCHEMA silver;
GO

-- Create GOLD schema
-- Purpose: Business analytics layer - contains aggregated, business-ready data
--          optimized for reporting and analysis
CREATE SCHEMA gold;
GO