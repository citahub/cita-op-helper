## 脚本说明

```
该脚本的目的是在收集CITA 运行异常时的错误信息，方便技术人员排查问题。
```

### 获取内容

```
CITA 服务日志
CITA 软件版本
CITA 运行配置文件
CITA 进程信息
操作系统版本信息
内存信息
硬盘信息
```

### 获取脚本
```
curl -O https://raw.githubusercontent.com/cryptape/cita-op-helper/master/cita-op-helper
```

###  执行
默认只获取200行日志，需要更多日志信息，请在脚本第二个参数填写日志数量。

运行时请在脚本后面填上CITA 部署路径，本地案例部署路径为：/data/cita_secp256k1_sha3
```
chmod +x ./cita-op-helper
./cita-op-helper /data/cita_secp256k1_sha3
./cita-op-helper /data/cita_secp256k1_sha3 1000
```
返回
```
/data/cita_secp256k1_sha3
  Please submit the /tmp/cita_info.tar.gz file to the administrator to help troubleshoot the issue. 
```
请将/tmp/目录下的 cita_info.tar.gz 文件提交给官方技术人员排查。
