
variable "project" {
  description = "GCP에 있는 프로젝트 이름 변수"
  default = "xenon-bastion-435305-q1"
}

variable "instance_name" {
  description = "생성"
  type = string
}

variable "credentials" {
  description = "GCP에 액세스하기 위한 json 파일"
  default = "../Common/credentials.json"
}

variable "instance_image" {
    default = {
      ubuntu20 = "ubuntu-2004-focal-v20240830"
      centos7 = "centos-7-v20191210"
      debian9 = "debian-9-stretch-v20191210"
      windows_server = "windows-server-2016-dc-v20200114"
  }
}

variable "region" {
  default = "us-central1" 
}

variable "zone" {
  default = "us-central1-a"  
}

variable "machine_type" {
  default = {
      f1-micro = "f1-micro"
      g1-small = "g1-small"
      e2-medium = "e2-medium"
  }
}

variable "network" {
  default ="default"
}
