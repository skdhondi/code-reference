module "ecr-repo" {
  source           = "./../dev-ecr/modules/ecr"
  ecr_name         = var.ecr_name
  tags             = var.tags
  image_mutability = var.image_mutability

}
