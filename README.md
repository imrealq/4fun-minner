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

##### Chạy k3s
https://medium.com/geekculture/deploying-a-monero-miner-to-kubernetes-d03e5bfcd4d9

1. Kiểm tra lại các bước `Chạy container thông thường` nhưng không run container

2. Push image lên docker hub để pull khi chạy
    `imrealq/xmrig:local` -> sửa tên trong file `xmrig.yaml` nếu cần

3. Tạo namespace
```
kubectl create ns xmrig
```

4. Run
```
kubectl apply -f xmrig.yaml
```

5. List các pod trong space là `xmrig`
```
kubectl get pods -n xmrig
```

6. Log chi tiết pod trong name space
```
kubectl describe pods -n xmrig <tên pod bước 5>
```

7. Xóa deployment tên `xmrig` trong space `xmrig`
```
kubectl delete deployments -n xmrig xmrig
```
