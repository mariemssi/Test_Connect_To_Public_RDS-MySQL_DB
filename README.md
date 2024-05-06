# Testing Connection to a Public RDS MySQL DB 

![image](https://github.com/mariemssi/Test_Connect_To_Public_RDS-MySQL_DB/assets/69463864/f85de234-28a8-4580-b18d-cb148fb7c19e)




## Provisioning Test Infrastructure with Terraform
1. Clone the GitHub Repository: `git clone <repository_url>`
  
2. Ensure that Terraform is installed on your local machine or Install it
   
3. Set Up your AWS Credentials AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY.  
   
4. Initialize Terraform: `terraform init`
   
5. Review Terraform Plan (Optional): `terraform plan`
   
   You can preview the changes Terraform will make to your infrastructure. For this, you should provide the Input Variables defined in variables.tf. You can define its values as default in the variables.tf file or you can define it as parameters of terraform plan and terraform apply commands
   or Terraform will prompt you to provide their values during the terraform apply process.

   😱 USERNAME and DB-PASSWORD are secrets and It's important to note that using these methods for secrets is not a best practice in production environments.
   For handling secrets securely, consider using more robust methods available in Terraform, such as using external secret management systems or environment variables.  
  
8. Apply Terraform Changes: `terraform apply`

    Wait for Terraform to Complete, this process may take some time. Once complete, Terraform will display a summary of the changes made.

## Testing the Connexion to the DB

### With MySQL Workbench

1. Define the needed parameters of the connexion like the screeshot below:
   
![image](https://github.com/mariemssi/Test_Connect_To_Public_RDS-MySQL_DB/assets/69463864/2c0fea00-ea87-4873-9fe0-246460e05881)


2. Run SQL queries After successfully connecting
 
## Destroying Test Infrastructure
  Destroy Resources (Optional): `terraform destroy`
  Once you have finished testing, it's important to destroy the test environment to avoid incurring unnecessary charges from AWS 😉.

*Please note that the testing environment discussed here is intended for testing purposes only and may not conform to best practices.*
