resource "aws_s3_bucket" "resume_site_s3_bucket" {
  bucket        = "resume.chadgud.dev"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "resume_site_s3_bucket_acl" {
  bucket = aws_s3_bucket.resume_site_s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "resume_site_bucket_policy" {
  bucket = aws_s3_bucket.resume_site_s3_bucket.id
  policy = data.aws_iam_policy_document.resume_site_bucket_policy_doc.json
}

data "aws_iam_policy_document" "resume_site_bucket_policy_doc" {
  statement {
    sid = "1"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::resume.chadgud.dev/*"]
  }
}

resource "aws_s3_object" "site-files" {
  for_each     = fileset("../src/", "*")
  bucket       = aws_s3_bucket.resume_site_s3_bucket.id
  key          = each.value
  source       = "../src/${each.value}"
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), null)
}
