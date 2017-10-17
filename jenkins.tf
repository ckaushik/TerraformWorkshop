resource "aws_instance" "jenkins_master" {
    # AWS ubuntu image in us-east-1 region
    ami = "ami-cd0f5cb6"

    instance_type = "t2.micro"
    subnet_id = "${element(data.aws_subnet_ids.all.ids, 0)}"
    vpc_security_group_ids = ["${aws_security_group.sg_jenkins.id}"]
    associate_public_ip_address = true
    key_name = "deployer"

    tags {
        Name = "jenkins-master"
    }

    provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ./deployer.pem -i '${aws_instance.jenkins_master.public_ip},' master.yml"
    }
}
