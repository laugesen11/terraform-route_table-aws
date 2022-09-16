#Declares variables
#
#  Variables included here:
#    - name                                : the name of this route table. Use in future settings
#    - vpc_id                              : the VPC this route table is assigned to
#    - tags                                : tags for this route table
#    - propagating_vgws                    : A list of IDs of virtual private gateways (VPN gateways) to auto propogate for
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
      })
  )
}

