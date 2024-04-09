# MINNER

1. Cài package cần thiết
    `bash ./install`
2. Kiểm tra file config.json
    trường `user` = `tên coin`:`địa chỉ ví`:`tên worker`
3. Thay đổi trường `CONTAINER_NAME` nếu cần
4. Thay đổi `--cpus` và  `--memory` trong file `run.sh` nếu cần
5. Chạy container
    `bash ./run.sh`
