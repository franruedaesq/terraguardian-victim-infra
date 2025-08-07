# VIOLATION 1: This S3 bucket is publicly readable.
# Rule Violated: "S3 buckets must not be public."
resource "aws_s3_bucket" "user_uploads_insecure" {
  bucket = "terraguardian-insecure-bucket-${random_id.id.hex}"
  acl    = "public-read"

  tags = {
    Name       = "Insecure User Uploads Bucket"
    CostCenter = "1001"
    # VIOLATION 2: This resource is missing the required 'Owner' tag.
    # Rule Violated: "All resources must have an 'Owner' tag."
  }
}

# VIOLATION 3: This EC2 instance type is not on the approved list (e.g., not a t2.micro).
# Rule Violated: "EC2 instances must be from the approved free-tier list."
resource "aws_instance" "app_server_non_compliant" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI in us-east-1
  instance_type = "t3.small"              # This is not a t2.micro

  tags = {
    Name       = "Non-Compliant App Server"
    Owner      = "dev-team"
    CostCenter = "1002"
  }
}

# A compliant resource for comparison
resource "aws_s3_bucket" "user_uploads_secure" {
  bucket = "terraguardian-secure-bucket-${random_id.id.hex}"

  tags = {
    Name       = "Secure User Uploads Bucket"
    Owner      = "dev-team"
    CostCenter = "1001"
  }
}

# Helper to ensure bucket names are unique
resource "random_id" "id" {
  byte_length = 8
}
