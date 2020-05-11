data aws_caller_identity current {

#Provision a Production Environment
module fargate_prod {
    source            = ./module
    
    #Environment Specifics:
    sdlc              = prod
    container_cpu     = 198
    container_memory  = 198
    app_count         = 2
}

#Provision a Development Environment
module fargate_dev {
    source            = ./module

    #Environment Specifics:
    sdlc              = dev
    container_cpu     = 198
    container_memory  = 198
    app_count         = 2


}