variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1f"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-08a52ddb321b32a8c"
    us-east-2 = "ami-08a52ddb321b32a8c"
  }
}
