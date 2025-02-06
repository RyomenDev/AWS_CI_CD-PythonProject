# Permissions to access the specified AWS Secrets Manager secret {SSM}

Permissions to access the specified AWS Secrets Manager secret. Here’s how you can fix it:

### Solution Steps:
## 1️⃣ Verify IAM Role Permissions
Ensure that the IAM role assigned to your AWS service (e.g., Lambda, ECS, EC2) has the necessary permissions to access Secrets Manager.

Go to the IAM console: AWS IAM Console
Find the IAM role associated with your service.
Attach or update the required policy:
Add this policy if it’s missing:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "secretsmanager:GetSecretValue"
      ],
      "Resource": "arn:aws:secretsmanager:REGION:ACCOUNT_ID:secret:SECRET_NAME"
    }
  ]
}
```
Replace REGION, ACCOUNT_ID, and SECRET_NAME with the appropriate values.
## 2️⃣ Check Trust Relationships
If your service (e.g., Lambda, ECS Task) assumes an IAM role, ensure that the trust policy allows the service to assume the role:

Navigate to IAM Roles > Trust Relationships
Ensure the following policy exists:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "secretsmanager.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```
## 3️⃣ Verify KMS Key Permissions (If Using Encryption)
If your secret is encrypted with a custom KMS key, ensure that your IAM role has kms:Decrypt permissions:

```json
{
  "Effect": "Allow",
  "Action": [
    "kms:Decrypt"
  ],
  "Resource": "arn:aws:kms:REGION:ACCOUNT_ID:key/KEY_ID"
}
```
Replace REGION, ACCOUNT_ID, and KEY_ID with your actual KMS Key ID.

## 4️⃣ Check Secret Policy
Go to Secrets Manager in AWS Console.
Select your secret and click on Resource Policy.
Ensure the IAM role is listed with secretsmanager:GetSecretValue permission.
## 5️⃣ Ensure Correct ARN Usage
The secret ARN should be correctly referenced in your code or environment variables.
Verify the ARN from the AWS Secrets Manager Console.
## 6️⃣ Test Permissions Using AWS CLI
Run the following AWS CLI command with your role:

```sh
aws secretsmanager get-secret-value --secret-id arn:aws:secretsmanager:REGION:ACCOUNT_ID:secret:SECRET_NAME --profile YOUR_PROFILE
```
If access is denied, update your permissions accordingly.