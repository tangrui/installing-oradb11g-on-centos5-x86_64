# 安装 Oracle Database 11g

以下命令如无特别说明，均使用 oracle 账号运行。

## 下载并上传安装文件

请从 Oracle 官方网站下载 Oracle Database 11g 的安装文件。因为我们是在 x86_64 架构的主机上来安装，所以请下载 Linux x86-64 版本的安装文件。

Oracle Database 11g 的安装文件分为 File1 和 File2 两部分，请确保正确下载。下载后的文件名应为：

```
linux.x64_11gR2_database_1of2.zip
linux.x64_11gR2_database_2of2.zip
```

将这两个文件上传到 oracle 账号的 home 目录下，并确保 oracle 账号有权限操作这些文件。

## 解压缩

进入 oracle 账号的 home 目录，执行：

```bash
unzip linux.x64_11gR2_database_1of2.zip
unzip linux.x64_11gR2_database_2of2.zip
```

解压缩以后会在 home 目录下生成 database 文件夹，将该文件夹移动到 `/u01/app/` 目录下：

```bash
mv database/ /u01/app/
```

## 修改并上传 Response 文件

请到[这里](../automatic_installation/assets/install.rsp)下载预先配置好的 Response 文件，并按照以下步骤进行修改：

1. 修改 ORACLE_HOSTNAME 参数
2. 修改 oracle.install.db.config.starterdb.globalDBName 参数
3. 修改 oracle.install.db.config.starterdb.SID 参数
4. 修改 oracle.install.db.config.starterdb.password.ALL 参数
5. 修改 oracle.install.db.config.starterdb.automatedBackup.ospwd 参数

将修改后的 Response 文件上传到 oracle 账号的 home 目录下。

## 安装

因为在上一步已经创建好一个 Response 文件，因此这里可以使用 Response 文件来安装：

```bash
/u01/app/database/runInstaller -responseFile /home/oracle/install.rsp
```

**注意：** `-responseFile` 参数一定要使用绝对路径。

该命令会启动图形化安装程序，且安装过程中的相关参数已按照 Response 文件中的配置进行填写，可以在此确认配置是否正确，并进行适当的修改。也可以不指定 Response 文件，而运行一个全新的安装过程。

![启动界面](assets/oracle/00.png)

Oracle Database 11g 安装程序启动界面。

![配置安全更新](assets/oracle/01.png)

此界面用来配置 My Oracle Support 账号，以获得安全更新。因为我们没有购买 Oracle 服务，因此不勾选任何内容，点击 **Next** 进入下一步。

![确认](assets/oracle/02.png)

由于前面一步没有输入任何信息，这里会提示确认不接收任何关键安全更新，点击 **Yes** 确认。

![选择安装选项](assets/oracle/03.png)

此界面用来选择安装选项，这里选 `Create and configure a database`（创建并配置数据库），点击 **Next** 进入下一步。

![选择系统类型](assets/oracle/04.png)

此界面用来选择系统类型，这里选 `Server Class`（服务器类型），点击 **Next** 进入下一步。

![节点选择](assets/oracle/05.png)

此界面用来选择节点安装选项，这里选 `Single instance database installation`（单实例数据库安装），点击 **Next** 进入下一步。

![选择安装类型](assets/oracle/06.png)

此界面用来选择安装类型，这里选 `Advanced install`（高级安装），点击 **Next** 进入下一步。

![选择产品语言](assets/oracle/07.png)

此界面用来选择产品语言，保持默认值 `English` 不变，点击 **Next** 进入下一步。

![选择数据库版本](assets/oracle/08.png)

此界面用来选择数据库版本，这里选 `Enterprise Edition`（企业版），点击 **Next** 进入下一步。

![指定安装位置](assets/oracle/09.png)

此界面用来指定 Oracle 数据库的安装位置，`Oracle Base` 设置为 `/u01/app/oracle`，而 `Software Location` 设置为 `/u01/app/oracle/product/11.2.0/dbhome_1`，点击 **Next** 进入下一步。

![创建 Inventory](assets/oracle/10.png)

此界面用来指定创建 Inventory 目录的参数，`Inventory Directory` 设置为 `/u01/app/oraInventory`，而 `oraInventory Group Name` 选择 `oinstall`，点击 **Next** 进入下一步。

![选择配置类型](assets/oracle/11.png)

此界面用来选择数据库配置类型，这里选 `General Purpose / Transaction Procssing`（基本用途 / 事务处理），点击 **Next** 进入下一步。

![设置数据库标识](assets/oracle/12.png)

此界面用来指定数据库标识，`Global database name` 设置为 `orcl.example.com`，而 `Oracle Service Identifier (SID)` 设置为 `orcl`，这两个值需要根据实际情况填写。点击 **Next** 进入下一步。

![指定配置参数（内存）](assets/oracle/13.png)

此界面用来配置 Oracle 数据库的自动内存管理，保持默认即可。

![指定配置参数（字符集）](assets/oracle/14.png)

此界面用来配置数据库所使用的字符集，选择 `Use Unicode (AL32UTF8)`。

![指定配置参数（安全）](assets/oracle/15.png)

此界面用来配置数据库的安全设置，保持默认即可。

![指定配置参数（样例 Schema）](assets/oracle/16.png)

此界面用来指定是否用样例 schema 创建数据库，保持默认即可，点击 **Next** 进入下一步。

![配置管理选项](assets/oracle/17.png)

此界面用来配置 Grid Control 的管理选项，因为我们没有安装集群，所以保持默认值即可，点击 **Next** 进入下一步。

![配置数据库存储选项](assets/oracle/18.png)

此界面用来配置数据库的存储选项，选择 `File System`（文件系统），并选定 `/u01/oradata/` 作为数据文件的存放目录。点击 **Next** 进入下一步。

![配置恢复选项](assets/oracle/19.png)

此界面用来配置数据库的自动备份策略，选中 `Enable automated backups`（启用自动备份），在 `Recovery area storage`（恢复区域存储）下选择 `File System`（文件系统），并指定路径到 `/u01/fast_recovery_area/`，并在最下面的 `Backup Job Operation System credentials`（备份作业操作系统凭据）中输入 oracle 账号的密码。点击 **Next** 进入下一步。

![配置账号密码](assets/oracle/20.png)

此界面用来配置各系统账号的密码，为了方便起见，这里选择 `Use the same password for all accounts`（为所有用户启用相同的密码），并在下面的输入框中，输入两次密码，点击 **Next** 进入下一步。

![密码安全性确认](assets/oracle/21.png)

如果输入的密码不符合 Oracle 推荐标准的要求，就会弹出此界面，让用户进行确认。如果想保持当前密码就选择 `Yes`，否则选择 `No` 返回修改密码。点击 **Next** 进入下一步。

![操作系统组许可](assets/oracle/22.png)

此界面保持默认即可，点击 **Next** 进入下一步。

![系统检查](assets/oracle/23.png)

此界面显示执行系统检查的进度，如果检查不成功，会列出不满足的系统配置或缺失的系统组件，需要用户在再次安装之前修改配置或安装组件。等待此界面完成，自动进入下一步。

![摘要](assets/oracle/24.png)

此界面显示了前面所做系统配置的摘要信息，如果发现问题，可以返回修改。也可以点击 `Save Response File...` 按钮将此配置保存为新的 Response 文件，待以后安装时使用。点击 **Finish** 开始安装。

![安装进行中](assets/oracle/25.png)

安装进行中...

![安装进行中](assets/oracle/26.png)

安装进行中...

![安装进行中](assets/oracle/27.png)

安装进行中...

![安装进行中](assets/oracle/28.png)

安装进行中，数据库配置助手...

![安装即将完成](assets/oracle/29.png)

此界面要求以 root 账号身份执行两个指定的脚本。

![执行脚本](assets/oracle/30.png)

打开 Terminal 程序，切换至 root 账号，再依次执行对话框中要求运行的两个脚本：

```
/u01/app/oraInventory/orainstRoot.sh
/u01/app/oracle/product/11.2.0/dbhome_1/root.sh
```

运行完成后点击 **OK**。

![安装完成](assets/oracle/31.png)

Oracel Database 11g 的安装过程至此完成。使用地址 https://orcl.example.com:1158/em 来访问数据库的企业管理器。
