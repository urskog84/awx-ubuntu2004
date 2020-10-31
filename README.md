# AWX on Ubuntu 20.04 LTS (Focal Fossa)
Install AWX om Ubuntu 20.04 LTS vagrant box.

## how to 

* vagrant plugin install vagrant-reload
* git clone https://github.com/urskog84/awx-ubuntu2004.git
* cd awx-centos
* change variables in /install_awx_manage.sh
* vagrant up
* drink coffe
* open browser to http://192.168.20.103

## problem?
ssh vagrant@192.168.20.103 -i ~/.vagrant.d/insecure_private_key 

## Insperation from 
- https://gist.github.com/davivcgarcia/86bb4746c430ec719235217daf8198d8
- https://github.com/r3ap3rpy/vagrantseries/tree/master/custommachines/awx
- https://www.youtube.com/watch?v=Ykzm-Yw8OCA&t=630s
- https://www.youtube.com/watch?v=iIQ62T-Gsxw&t=11s
