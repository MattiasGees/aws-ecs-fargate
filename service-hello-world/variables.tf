variable "cluster_id" {
  description = "The ECS cluster ID"
  type        = string
}

variable "subnets" {
  description = "Subnets to deploy the Fargate tasks"
}

variable "security_groups" {
  description = "Security Groups for Fargate tasks"
}
