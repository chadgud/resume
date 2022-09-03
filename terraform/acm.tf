resource "aws_acm_certificate" "cert" {
  domain_name       = "resume.chadgud.dev"
  validation_method = "DNS"
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn = aws_acm_certificate.cert.arn
}
