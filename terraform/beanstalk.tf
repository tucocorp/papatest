resource "aws_elastic_beanstalk_application" "app" {
  name        = "${var.app_name}"
  description = "${var.app_name}"
}

resource "aws_elastic_beanstalk_environment" "production" {
  name                = "production"
  application         = "${aws_elastic_beanstalk_application.app.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.8 running Ruby 2.6 (Puma)"

  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "ListenerEnabled"
    value     = "true"
  }

  setting {
    namespace = "aws:elbv2:listener:80"
    name      = "Protocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RAILS_ENV"
    value     = "production"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "SECRET_KEY_BASE"
    value     = "${var.secret_key_base}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_instance_profile.build.name}"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "${var.key_name}"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${aws_vpc.vpc.id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.subnet1.id},${aws_subnet.subnet2.id}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_USERNAME"
    value     = "${aws_db_instance.rds-app-prod.username}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_PASSWORD"
    value     = "${aws_db_instance.rds-app-prod.password}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_DATABASE"
    value     = "${aws_db_instance.rds-app-prod.name}"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "RDS_HOSTNAME"
    value     = "${aws_db_instance.rds-app-prod.address}"
  }
}

output "url" {
  value = "${aws_elastic_beanstalk_environment.production.cname}"
}
