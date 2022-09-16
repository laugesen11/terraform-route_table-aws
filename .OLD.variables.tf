#Declares variables
#
#  Variables included here:
#    - name                                : the name of this route table. Use in future settings
#    - vpc_id                              : the VPC this route table is assigned to
#    - tags                                : tags for this route table
#    - propagating_vgws                    : A list of IDs of virtual private gateways (VPN gateways) to auto propogate for
#NOTE: All the below route variables are intended to be created dynamically, so read carefully the comments around each one 
#      to ensure you include the correct keys/values
#    - internet_gateway_routes             : Map of routes to internet gateways
#    - egress_only_internet_gateway_routes : Map of routes to egress only internet gateways
#    - vpn_gateway_routes                  : Map of routes to VPN gateways
#    - nat_gateway_routes                  : Map of routes to NAT gateways
#    - vpc_peering_routes                  : Map of routes to VPC Peering connections
#    - transit_gateway_routes              : Map of routes to Tansit Gateways 
#    - vpc_endpoints_routes                : Map of routes to VPC Endpoints
#    - carrier_gateway_routes              : Map of routes to Carrier Gateways (Wavelength Zones)
#    - network_interface_routes            : Map of routes to Network interface IDs
#

#This feeds in a map of VPCs that you would create through a for_each loop
variable "vpcs" {
  description = "The VPCs that we can resolve VPC names to"
  default = {}
  type = map
}

#Set up the route tables
variable "route_tables" {
  description = "Defines route tables and their rules"
  default     = null

  type = list(
      object({
        #Name of route table
        name    = string

        #Can be set to VPC name set in this module in vpc_setup variable or external VPC id
        vpc     = string
 
        #Sets optional values for route table
        #Valid values:
        # - propagating_vgws - A list of virtual gateways for propagation.
        # - tags="<tag_name1>=<tag_value1>,<tag_name2>=<tag_value2>,..."
        options = map(string)
        
#        routes           = list(object({
#            #Can specify three kinds of targets
#            #  - IPv4 CIDR block            - an IP range in the ##.##.##.##/## format. Most common, identified by '.' in string
#            #  - IPv6 CIDR block            - an IP range in IPv6 style (####:####:####/##). Identified by the ':' in the string
#            #  - destination prefix list ID - An AWS managed prefix list ID. Identified by starting with 'pl-'
#            target = string
#   
#            #Sets options for this route
#            #MUST SET THE VALUE 'type' or this module will error
#            #Valid values for 'type': 
#            #  - "internet gateway" - automatically resolves route to internet gateway attached to VPC
#            #  - "egress only internet gateway" - automatically resolves route to egress only internet gateway attached to VPC
#            #  - "vpn gateway" - automatically resolves route to  vpn gateway attached to VPC
#            #  - "nat gateway" - resolves route to nat gateway specified in "destination". Can use name in module or external id
#            #  - "vpc peering" - resolves route to vpc peering setup specified in "destination". Can use name in module or external id
#            #  - "vpc endpoint" - resolves route to vpc endpoint specified in "destination". Can use name in module or external id
#            #  - "transit gateway" - resolves route to transit gateway in "destination". Must attach transit gateway to VPC. Can use name in module or external id
#            #  - "carrier gateway" - resolves route to carrier gateway in "destination". Can only use ID
#            #  - "network interface" - resolves route to network interface in "destination". Can only use ID
#            #OTHER options:
#            #  - destination="<The name or ID of the destination object. Be careful to match to the type>"
#            route_options = map(string)
#          })
#        )
      })
  )
}

#Input the existing AWS gateways into this module
#Each of these are maps of AWS resources 
#variable "internet_gateways" {
#  description = "Internet gateways we want to route to"
#  default = {}
#  type = map
#}
#
#variable "egress_only_internet_gateways" {
#  description = "Egress only internet gateways we want to route to"
#  default = {}
#  type = map
#}
#
#variable "vpn_gateways" {
#  description = "VPN gateways we want to route to"
#  default = {}
#  type = map
#}
#
#variable "nat_gateways" {
#  description = "NAT gateways we want to route to"
#  default = {}
#  type = map
#}
#
#variable "vpc_peering_connections" {
#  description = "VPC Peering connections we want to route to"
#  default = {}
#  type = map
#}
#
#variable "vpc_endpoints" {
#  description = "VPC endpoints we want to route to"
#  default = {}
#  type = map
#}
#
#variable "transit_gateways" {
#  description = "Transit gateways we want to route to"
#  default = {}
#  type = map
#}

