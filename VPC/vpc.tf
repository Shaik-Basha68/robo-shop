resource "aws_vpc" "main" {
    cidr_block           = var.cidr_block
    enable_dns_hostnames = true
    instance_tenancy     = "default"
    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-vpc"
        }
    )
}


resource "aws_subnet" "public" {
    count                   = length(var.public_subnet_cidrs)
    cidr_block             = var.public_subnet_cidrs[count.index]
    vpc_id                 = aws_vpc.main.id
    availability_zone      = local.azs[count.index]
    map_public_ip_on_launch = true
    tags = merge(
        var.subnet_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-public-${count.index + 1}"
        }
    )
}

resource "aws_subnet" "private" {
    count                   = length(var.private_subnet_cidrs)
    cidr_block             = var.private_subnet_cidrs[count.index]
    vpc_id                 = aws_vpc.main.id
    availability_zone      = local.azs[count.index]
    map_public_ip_on_launch = false
    tags = merge(
        var.subnet_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-private-${count.index + 1}"
        }
    )
}

resource "aws_subnet" "database" {
    count                   = length(var.database_subnet_cidrs)
    cidr_block             = var.database_subnet_cidrs[count.index]
    vpc_id                 = aws_vpc.main.id
    availability_zone      = local.azs[count.index]
    map_public_ip_on_launch = false
    tags = merge(
        var.subnet_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-database-${count.index + 1}"
        }
    )
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-igw"
        }
    )
}

resource "aws_eip" "nat" {
    count = length(var.private_subnet_cidrs)
    domain = "vpc"
    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-nat-${count.index + 1}"
        }
    )
}

resource "aws_nat_gateway" "main" {
    count = length(var.private_subnet_cidrs)
    allocation_id = aws_eip.nat[count.index].id
    subnet_id     = aws_subnet.public[count.index].id
    depends_on = [aws_internet_gateway.main]
    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-nat-${count.index + 1}"
        }
    )
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-public-rt"
        }
    )
}

resource "aws_route" "public" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.main.id
}   

resource "aws_route_table_association" "public" {
    count          = length(var.public_subnet_cidrs)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-private-rt-${count.index + 1}"
        }
    )
}

resource "aws_route" "private" {
    count                  = length(var.private_subnet_cidrs)
    route_table_id         = aws_route_table.private[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.main[count.index].id
}

resource "aws_route_table_association" "private" {
    count          = length(var.private_subnet_cidrs)
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}   

resource "aws_route_table" "database" {
    count = length(var.database_subnet_cidrs)
    vpc_id = aws_vpc.main.id
    tags = merge(
        var.vpc_tags,
        local.common_tags,
        {
            Name = "${local.common_name}-database-rt-${count.index + 1}"
        }
    )
}

resource "aws_route" "database" {
    count                  = length(var.database_subnet_cidrs)
    route_table_id         = aws_route_table.database[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.main[count.index].id
}

resource "aws_route_table_association" "database" {
    count          = length(var.database_subnet_cidrs)
    subnet_id      = aws_subnet.database[count.index].id
    route_table_id = aws_route_table.database[count.index].id
}   