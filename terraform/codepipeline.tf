resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.app_name}-artifacts"
  acl    = "private"
  force_destroy = true
}

resource "aws_codepipeline" "pipeline" {
  name     = "${var.app_name}-pipeline"
  role_arn = "${aws_iam_role.build.arn}"

  artifact_store {
    location = "${aws_s3_bucket.artifacts.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source"]

      configuration {
        Owner      = "${var.github_organization}"
        Repo       = "${var.github_repository}"
        Branch     = "${var.github_branch}"
        OAuthToken = "${var.github_token}"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "ElasticBeanstalk"
      input_artifacts = ["source"]
      version = "1"

      configuration {
        ApplicationName = "${aws_elastic_beanstalk_application.app.name}"
        EnvironmentName = "${aws_elastic_beanstalk_environment.production.name}"
      }
    }
  }
}
