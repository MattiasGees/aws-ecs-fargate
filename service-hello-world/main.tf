resource "aws_cloudwatch_log_group" "hello_world" {
  name              = "hello_world"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "hello_world" {
  family = "hello_world"
  requires_compatibilities = ["EC2", "FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512

  container_definitions = <<EOF
[
  {
    "name": "hello_world",
    "image": "nginx"
  }
]
EOF
}

resource "aws_ecs_service" "hello_world" {
  name            = "hello_world"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.hello_world.arn

  desired_count = 1

  launch_type = "EC2"

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
}

resource "aws_ecs_service" "hello_world_fargate" {
  name            = "hello_world_fargate"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.hello_world.arn

  desired_count = 1

  launch_type = "FARGATE"

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0

  network_configuration {
    subnets = var.subnets
    assign_public_ip =  true
    security_groups = var.security_groups
  }
}
