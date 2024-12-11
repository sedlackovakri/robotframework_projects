# Google Sheets API in Robot Framework

## Environment setup and authentication when working with Google Sheets API


### **Step 1: Creating a project in Google Cloud Console**

Log in to Google Cloud Console: https://console.cloud.google.com/.  
In the top panel, click on **Select a project** and then click on **New Project.**  
Enter the project name (e.g., "Google Sheets API Project") and click **Create**.

### **Step 2: Enabling Google Sheets API**

In the left menu, click on **API & Services → Library**.  
In the search field, type Google Sheets API.   
Click on **Google Sheets API** and then click **Enable** to activate the API for your project.  

### **Step 3: Creating a Service Account**

In Google Cloud Console, go to **IAM & Admin → Service Accounts**.  
Click **Create Service Account**.  
Enter a name for the account, such as "Sheets API Service Account". Click **Create** and continue.  
In the Role section, select the **Project → Owner or Editor role**.   
This role grants the Service Account sufficient permissions to work with the API. Click **Done.**  
Click on the **service account** (email) and in the **KEYS** section,   
click **ADD KEY → Create new key** and choose the **JSON** format.  
Click **Create**, which will download the JSON file containing the service account's credentials   
(this file is needed for authentication).  

### **Step 4: Sharing access to the Google Sheets document**

Open the Google Sheets document you want to use with the Google Sheets API.  
Click **Share** in the top right corner.  
Enter the service account’s email address   
(found in the JSON file or in Google Cloud Console under Service Accounts).  
Grant the service account the necessary permissions (e.g., Editor)     
to allow it to read and write to the sheet.   

### **Step 5: Setting up Robot Framework and authentication**

To work with Google Sheets, authentication is required first.
How does it work?
The process involves obtaining an access token using the credentials 
from the previously downloaded JSON file. 
This token is then sent as part of the HTTP headers to the endpoint. 
The following library helps with this process. 
(the entire process is executed by the keyword `Init Sheets`).

Install the RPA Cloud Google library:  

`pip install rpaframework-google  
`
Library documentation: https://rpaframework.org/libdoc/RPA_Cloud_Google.html    

Open the robot file and add the library in the Settings section:   

`Library   RPA.Cloud.Google    `

Copy the authentication JSON file (created in Step 3)   
to your project directory and name it **serviceaccount.json**.  

Create a variable with the path to serviceaccount.json using path from repository root:  
Right-click on the serviceaccount.json file → **Copy Path/Reference → Path From Repository Root**  

Initializing Google Sheets using the keyword Init Sheets:

`Init Sheets   ${JSON_SERVICEACCOUNT}  `