resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my-unique-s3-bucket-name" # Replace with your unique bucket name

  tags = {
    Name = "my-s3-bucket"
  }
}

resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    origin_id   = "s3-origin"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "My CloudFront Distribution"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = "my-cloudfront-distribution"
  }
}
