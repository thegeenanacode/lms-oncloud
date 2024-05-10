resource "aws_s3_bucket" "lms_s3_bucket" {
  bucket = "lms-oncloud-course-content"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Purpose = "CourseContentStorage"
  }
}

resource "aws_efs_file_system" "lms_efs" {
  creation_token = "lms-efs"

  tags = {
    Name = "LMSOncloudEFS"
  }
}
