output "instance_id" {
  value = aws_instance.mywebapp.id
}

output "bucket_name" {
  value = aws_s3_bucket.code-databucket.bucket
}

output "role_name" {
  value = aws_iam_role.s3_access_role.name
}
