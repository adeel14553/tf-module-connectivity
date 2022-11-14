
module "ecs" {
  source = "./modules/ecs"
}

# data "mod-ecs" "ecs1" {
#   name = "mod-ecs-ecs1"  #Implicit dependencies
# }

module "alb" {
  source = "./modules/alb"

}





