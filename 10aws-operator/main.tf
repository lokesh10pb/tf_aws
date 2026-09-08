terraform {
}
#Number list 
variable "num_list" {
  type    = list(number)
  default = [1, 2, 3, 4, 5]
}



#object list 
variable "person-list" {
  type = list(object({
    fname = string
    lname = string
  }))
  default = [{
    fname = "abc"
    lname = "xyz"

    },
    {
      fname = "sda"
      lname = "fdsf"
  }]
}

#Map
variable "map-list" {
  type = map(number)
  default = {
    "on1"   = 1
    "two"   = 2
    "three" = 3
  }

}

#calculations

locals {
  mul = 2 * 2
  add = 2 + 2
  eq  = 2 != 3
  #doble list 
  double = [for num in var.num_list : num * 2]
  #odd number 
  odd = [for num in var.num_list : num if num % 2 != 0]
  # person list
  fname = [for person in var.person-list : person.fname]

}



output "output" {
  value = local.add

}
output "eq" {
  value = local.eq

}
output "double" {
  value = local.double

}
output "odd" {
  value = local.odd

}
output "name" {
  value = local.fname
}


#Functions


locals {
  value = "Hello heLLo "
}
variable "string-list" {
  type    = list(string)
  default = ["server", "serverDev", "serverPord","server"]

}


output "my_opt" {
  # value = lower(local.value) #upper(local.value)
  #   value = split(" ",local.value)
  # value = max (1,2,3,4,5,6) #min(1,2,3,4,5,6)
  #   value = length(var.string-list)
#   value = join(":", var.string-list)
   value = toset(var.string-list)

}
