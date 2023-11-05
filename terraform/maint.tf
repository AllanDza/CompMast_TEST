provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "my_cluster" {
  name = "my-django-cluster"
}

resource "aws_ecs_task_definition" "my_task" {
  family                   = "my-django-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = aws_iam_role.my_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "my-django-app"
      image = "your-docker-image-url/my-django-app:latest"
    }
  ])
}

resource "aws_iam_role" "my_execution_role" {
  name = "my-django-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
    }]
  })
}

resource "aws_ecs_service" "my_service" {
  name            = "my-django-service"
  cluster         = aws_ecs_cluster.my_cluster.id
  task_definition = aws_ecs_task_definition.my_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets = [aws_subnet.my_subnet.id]
    security_groups = [aws_security_group.my_security_group.id]
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  # Define your subnet details
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id
  # Define your security group rules
}

resource "aws_vpc" "my_vpc" {
  # Define your VPC details
}

