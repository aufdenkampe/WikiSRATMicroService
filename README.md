# SRAT
## Installation

### Database
Step 1: Login to ASW (account EDS)
create an RDS instance:
Select postgres
Postgressql-license
PostgresSql 10.6R1
database instance: eds-aws-db-1
masterusename:eds
datbase name: drwi
port: 5432
DB Parameter group: default.postgres10
IAM DB authentication: Disable
No encrpt
Backup: 0 days
enable enhanced monitoring
Disable performance insigts
Enable Minor version upgrade
maintance window no preference
Create Database

### Start Python
create a Lambda function
Use a blue print
microservice-http-endpoint "Might have to search for this"
create a function: SratRunModel
Execution role: Create a new role from Aws  policy template
Role Name: admin
Simple Microservice permission
API Gateway Trigger
API: Create a new API
Security: Open with API key
API Name: SRAT-API
Deployment stage prod
TO DO oupdate Lamnda Function CODE





