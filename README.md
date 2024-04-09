# MINNER

### Chạy container thông thường
1. Cài package cần thiết
```
bash ./install
```
2. Kiểm tra file config.json
    trường `user` = `tên coin`:`địa chỉ ví`:`tên worker`
3. Thay đổi trường `CONTAINER_NAME` nếu cần
4. Thay đổi `--cpus` và  `--memory` trong file `run.sh` nếu cần
5. Chạy container
```
bash ./run.sh
```


### Cài k3s
##### Cài master cho raspberry pi

1. 
```
nano /boot/firmware/cmdline.txt
```

Thêm `cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1`

```
reboot
```

2. Fixed ip master 192.168.1.102
```
curl -sfL https://get.k3s.io | sh -

nano /etc/systemd/system/k3s.service
	ExecStart=/usr/local/bin/k3s \
	    server \
	    	'--node-ip=192.168.1.102' \

systemctl daemon-reload
systemctl restart k3s
```

##### Cài worker nodes cho orangepi
1. 
```
nano /boot/cmdline.txt
```

Thêm `cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1`

```
reboot
```

2. Lấy node token K3S_TOKEN
```
export MASTER_SERVER=192.168.1.102
export K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)
export K3S_URL=https://${MASTER_SERVER}:6443

curl -sfL https://get.k3s.io | sh -
```

3. Fixed ip node 192.168.1.103
```
nano /etc/systemd/system/k3s-agent.service
	ExecStart=/usr/local/bin/k3s \
	    agent \
		'--node-ip=192.168.1.103' \

systemctl daemon-reload
systemctl restart k3s-agent
```
