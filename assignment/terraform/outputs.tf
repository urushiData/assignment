output "lb_public_ip" {
  value = module.compute.lb_public_ip
}

output "web_public_ip" {
  value = module.compute.web_public_ip
}

output "db_public_ip" {
  value = module.compute.db_public_ip
}
