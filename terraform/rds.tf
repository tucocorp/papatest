resource "aws_db_instance" "rds-app-prod" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "9.5.15"
  instance_class       = "db.t2.micro"
  identifier           = "app-prod"
  name                 = "kuiz_production"
  username             = "kuiz"
  password             = "${var.db_password}"
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  multi_az             = "false"
  vpc_security_group_ids = ["${aws_security_group.allow_postgresql.id}"]
  storage_type         = "gp2"
  backup_retention_period = 30
  skip_final_snapshot = true

  tags {
    Name = "rds-appprod"
  }
}
