locals {
  suffix = var.suffix 

  endpoint_subnet_ranges = cidrsubnets(
    var.vnet_address_space[1], 
    1,                         
    1                          
  )
}
