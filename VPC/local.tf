locals {

    common_tags = {
        Project = "var.Project_name"
        Env     = "var.Environment"
    }
    common_name = "${var.Project_name}-${var.Environment}"
    azs= slice(data.aws_availability_zones.available.names, 0, 2)
}