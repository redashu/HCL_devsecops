# provider means always -- what is your target cloud 
provider "aws" {
    region = "us-east-2" # name of Ohio region  
   # access_key =  "" we have already configured it using aws configure 
   # secret_key =  ""
}

#         name of resource  name of vm 
resource "aws_instance" "ashuvm1" {
    ami = "ami-0fa49cc9dc8d62c84"
    instance_type = "t2.micro"
    tags = {
        "Name" = "ashu-vm1-by-tf"
    }
    key_name = "ashuday2"
    
} 
