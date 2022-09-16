#Sets up local configuration for route tables based on module inputs
#These configurations are then fed into the 'routes' module in main.tf
#The only thing created here is the locals block

locals {
  #Configures the overall settings for the route tables
  route_table_config = {
    for item in var.route_tables: item.name => { 
      #If vpc_name_or_id is set to a VPC name in this module, we use that VPC id. If not, we assume this is an external VPC id
      "vpc_id"           = lookup(var.vpcs,item.vpc,null) != null ? var.vpcs[item.vpc].vpc.id : item.vpc
      "propagating_vgws" = lookup(item.options,"propagating_vgws",null) == null ? [] : split(",",item.options["propagating_vgws"])
      "tags"             = lookup(item.options,"tags",null) == null ? {} : {
                             for tag in split(",",item.options["tags"]):
                               element(split("=",tag),0) => element(split("=",tag),1)
                           }
    }
  }  
}

resource "aws_route_table" "route_tables"{
  for_each         = local.route_table_config
  vpc_id           = each.value.vpc_id
  propagating_vgws = each.value.propagating_vgws
  tags             = merge({"Name" = each.key},each.value.tags)
}

