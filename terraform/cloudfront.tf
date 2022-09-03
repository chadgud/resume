resource "aws_cloudfront_distribution" "resume-site-cloudfront-distribution" {
  aliases = ["resume.chadgud.dev"]
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    forwarded_values {
      cookies {
        forward = "none"
      }
      query_string = false
    }
    target_origin_id       = "s3-resume.chadgud.dev"
    viewer_protocol_policy = "allow-all"
  }
  default_root_object = "index.html"
  enabled             = true
  origin {
    domain_name = aws_s3_bucket.resume_site_s3_bucket.bucket_regional_domain_name
    origin_id   = "s3-resume.chadgud.dev"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.resume-site-cloudfront-oai.cloudfront_access_identity_path
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "resume-site-cloudfront-oai" {

}
