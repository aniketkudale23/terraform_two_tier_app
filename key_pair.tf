resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = file("/Users/aniket/Desktop/learning/cloud/aws_projects/assignment_project/terraform_public_key.pub") 
}
