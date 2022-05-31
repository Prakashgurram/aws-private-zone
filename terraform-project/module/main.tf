resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_1}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "custom-vpc-1"
  }
}

resource "aws_vpc" "vpc2" {
  cidr_block           = "${var.vpc_cidr_2}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "custom-vpc-2"
  }
}

data "aws_route53_zone" "selected" {
  name = "cloudlab123456.info"
  private_zone = true
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name = "www.${data.aws_route53_zone.selected.name}"
  type = "A"
  ttl = "300"
  records = ["10.0.0.1"]
}

resource "aws_route53_zone_association" "vpc_one" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  vpc_id  = "${aws_vpc.vpc1.id}"
}

