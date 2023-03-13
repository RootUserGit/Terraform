output "Amazon_linux_2_machine_IP" {
  description = "ip"
  value = "${aws_instance.amzn2.public_ip}"
}


output "UBUNTU_1_machine_IP" {
  description = "ip"
  value = "${aws_instance.ubuntu1.public_ip}"
}


output "UBUNTU_2_machine_IP" {
  description = "ip"
  value = "${aws_instance.ubuntu2.public_ip}"
}

