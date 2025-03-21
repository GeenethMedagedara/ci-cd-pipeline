provider "aws" {
  region = "us-east-1"
}

resource "aws_ecs_cluster" "main" {
  name = "my-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "my-app"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "my-app",
      "image": "my-dockerhub-username/my-app:latest",
      "memory": 512,
      "cpu": 256,
      "portMappings": [
        {
          "containerPort": 5000,
          "hostPort": 5000
        }
      ]
    }
  ]
  DEFINITION
}
