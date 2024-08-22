# Synchronous-target
Restart to automatically synchronize all package names to the target.txt of Tricky Store

重启自动将所有包名同步至Tricky Store的target.txt

加入跳过APatch包名会导致APatch使用keystore服务加密的超级密钥不可信,每次打开AP都要重新输入超级密钥.

Adding skip APatch package name will cause the super key encrypted by APatch using keystore service to be untrustworthy, and you have to re-enter the super key every time you open the AP

Automatically recursively detects and automatically updates the target.txt file when installing or uninstalling apps

自动循环检测，并在安装或卸载应用时自动更新 target.txt 文件

Each loop checks the names of currently installed packages and compares them with the ones in target.txt. If it finds a newly installed application, it adds the package name to target.txt; if it finds an uninstalled application, it removes the corresponding package name from target.txt

每次循环都会检查当前已安装的包名，并与 target.txt 中的包名进行比较。如果发现新安装的应用，它会将包名添加到 target.txt 中；如果发现已卸载的应用，它会从 target.txt 中删除相应的包名
