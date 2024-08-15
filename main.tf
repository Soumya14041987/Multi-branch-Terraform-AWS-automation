resource "aws_instance"  "mywebapp" {
    ami = var.ami
    instance_type = var.instance_type

    tags {
        Name = "Fortescue-${var.environment}-Instance"
    }
}

resource "aws_s3_bucket" {
    bucket = "fortescue-${var.environment}-bucket"

    tags{
        Name = "Fortescue-${var.environment}-bucket"
        Environment = var.environment
    }
}

resource "aws_iam_role"  "s3_access_role" {
    name = "s3-access-role-${var.environment}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_access_policy" {
  name = "s3-access-policy-${var.environment}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "${aws_s3_bucket.code-databucket.arn}/*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "s3_access_attachment" {
  role       = aws_iam_role.s3_access_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

resource "aws_instance" "attach_role" {
  ami           = var.ami  # Use a valid AMI ID for your region
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_role.s3_access_role.name

  tags = {
    Name        = "AttachRole-${var.environment}-Instance"
    Environment = var.environment
  }
}