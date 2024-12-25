# Data Pipeline Demo

## Overview
This subfolder contains scripts and configurations for the data pipeline demo, which moves data from a local SQL Server (AdventureWorksLT2019) to Azure Blob Storage using Azure Data Factory (ADF) and then creates a table in Azure SQL Database.

## Steps for Demo

### Step 1: Create Azure Blob Storage
1. **Sign in to the Azure portal**.
2. **Create a storage account**:
   - Navigate to "Storage accounts" and click "Create".
   - Fill in the required details (Subscription, Resource group, Storage account name, etc.).
   - Click "Review + create" and then "Create".
3. **Create a container**:
   - Go to your storage account.
   - Under "Data storage", select "Containers".
   - Click "+ Container", name it (e.g., `mycontainer`), and set the public access level to "Private".

### Step 2: Set Up Azure Data Factory (ADF)
1. **Create a Data Factory**:
   - In the Azure portal, search for "Data factories" and click "Create".
   - Fill in the required details and click "Review + create" and then "Create".
2. **Create a Self-hosted Integration Runtime**:
   - In your Data Factory, go to "Manage" and then "Integration runtimes".
   - Click "+ New" and select "Self-hosted".
   - Follow the instructions to download and install the integration runtime on your local machine.

### Step 3: Create Linked Services in ADF
1. **SQL Server Linked Service**:
   - In your Data Factory, go to "Manage" and then "Linked services".
   - Click "+ New" and select "SQL Server".
   - Configure the connection to your local SQL Server.
2. **Azure Blob Storage Linked Service**:
   - Click "+ New" and select "Azure Blob Storage".
   - Configure the connection to your Blob Storage account.

### Step 4: Create Datasets in ADF
1. **SQL Server Dataset**:
   - In your Data Factory, go to "Author" and then "Datasets".
   - Click "+ New" and select "SQL Server".
   - Configure the dataset to point to your SQL Server table.
2. **Blob Storage Dataset**:
   - Click "+ New" and select "Azure Blob Storage".
   - Configure the dataset to point to the container and blob where you want to store the data.

### Step 5: Create a Pipeline in ADF
1. **Create a Pipeline**:
   - In your Data Factory, go to "Author" and then "Pipelines".
   - Click "+ New" to create a new pipeline.
2. **Add a Copy Activity**:
   - Drag the "Copy data" activity to the pipeline canvas.
   - Configure the source to use the SQL Server dataset.
   - Configure the sink to use the Blob Storage dataset.
3. **Run the Pipeline**:
   - Save and publish your pipeline.
   - Trigger a pipeline run to copy the data from SQL Server to Blob Storage.

### Step 6: Create a Table in Azure SQL Database
1. **Create an Azure SQL Database**:
   - In the Azure portal, search for "SQL databases" and click "Create".
   - Fill in the required details and click "Review + create" and then "Create".
2. **Create a Table**:
   - Connect to your Azure SQL Database using SQL Server Management Studio (SSMS).
   - Use a SQL script to create a new table and load data from the blob storage.

Here's an example SQL script to create a table and load data:
```sql
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    EmailAddress NVARCHAR(50)
);

-- Load data from Blob Storage (assuming you have a CSV file in the blob)
BULK INSERT Customer
FROM 'https://<your_storage_account>.blob.core.windows.net/<your_container>/Customer.csv'
WITH (
    DATA_SOURCE = 'MyBlobStorage',
    FORMAT = 'CSV',
    FIRSTROW = 2
);