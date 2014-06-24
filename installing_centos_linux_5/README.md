# 安装 CentOS Linux 5

将含有 CentOS Linux 5 的安装光盘放入光驱中并重启计算机，等待进入安装界面。

![初始安装界面](assets/centos/01.png)

该界面用来选择安装程序的运行模式，有图形模式和文本模式，还有其他一些功能，对应不同的功能键。这里我们直接按回车键，进入图形化安装界面。

![检测安装介质](assets/centos/02.png)

该界面显示是否需要检测安装介质，如果选择 **OK** 则系统自动检测安装介质的完整性，这个过程需要花费几分钟的时间。这里我们选择 **Skip** 跳过此过程直接安装。

![图形安装界面](assets/centos/03.png)

直接点击 **Next** 进入下一步。

![选择安装过程中使用的语言](assets/centos/04.png)

该界面是选择在安装过程中需要使用的语言，这里我们直接默认 `English (English)`，点击 **Next** 进入下一步。

![选择键盘](assets/centos/05.png)

该界面是用来选择系统键盘布局的，对于一般的键盘而言，直接默认 `U.S. English` 即可，点击 **Next** 进入下一步。

![警告](assets/centos/06.png)

该界面显示了一个警告信息，说文件分区表不可读，如果需要创建新的分区就要把硬盘初始化，这会导致丢失磁盘上的所有信息。出现该警告信息的原因是因为我们是在一台全新的主机上安装操作系统，硬盘还没有经过格式化。所以在这里可以直接忽略此信息，点击 **Yes**。

![警告](assets/centos/07.png)

由于我们的系统有两块物理硬盘，所以上面的警告信息会出现两次（上一次是说设备 sda，这一次是说设备 sdb），同样无需过多考虑，点击 **Yes** 进入下一步。

![分区](assets/centos/08.png)

该界面显示需要如何对硬盘进行分区。在第一个下拉列表中，选择 `Remove all partitions on selected drives and create default layout.` 意思是说在选中的硬盘驱动器中移除所有的分区并创建默认布局。在下面的选择框中，注意选中需要进行分区的物理硬盘（我们这里有两块），选中最后面的 `Review and modify partitioning layout` 复选框，以便在下一个界面中预览并修改分区布局。点击 **Next** 进入下一步。

![警告](assets/centos/09.png)

该界面又是一条警告信息，说已经选择了移除下列设备中的所有分区及数据，问是否确定。这时需要检查一下前面一步的选择是否正确，尤其是硬盘中存在数据的情况下。由于我们这里都是空硬盘，所以直接选择 **Yes** 进入下一步。

![分区布局信息](assets/centos/10.png)

该界面显示了详细的分区信息，确保分区时使用了逻辑卷管理（LVM）。基本上保持默认设置即可，点击 **Next** 进入下一步。

![GRUB](assets/centos/11.png)

该界面用来配置 boot loader，这里选择 `The GRUB boot loader will be installed on /dev/sda.`，意思是说将 GRUB boot loader 安装到 /dev/sda 设备上。然后点击 **Next** 进入下一步。

![网络](assets/centos/12.png)

该界面用来配置网络设备。根据系统硬件所配网卡数量的不同，第一个列表中的信息会有所差别。选中每一个网卡设备进行配置，这里为了方便起见，我们在安装过程中使用默认值，稍后再在系统中进行配置。点击 **Next** 进入下一步。

![时区](assets/centos/13.png)

该界面用来设置时区，可以在地图上点选，也可以直接在下拉列表中选择。这里我们选择 `Asia/Shanghai`，点击 **Next** 进入下一步。

![设置 root 账号密码](assets/centos/14.png)

该界面用来设置 root 账号的密码，连续输入两个同样的密码，点击 **Next** 进入下一步。

![选择组件](assets/centos/15.png)

该界面用来选择需要安装的组件，这里我们进行默认安装，点击 **Next** 进入下一步。

![提示](assets/centos/16.png)

该界面显示了一些提示信息，说明安装日志和 kickstart 文件的生成位置，直接点击 **Next** 开始安装。

![安装](assets/centos/17.png)

开始安装...

![安装进行中](assets/centos/18.png)

安装进行中...

![安装进行中](assets/centos/19.png)

安装进行中...

![安装即将完成](assets/centos/20.png)

安装即将完成...

![安装完成](assets/centos/21.png)

安装完成，将安装光盘从光驱中取出，点击 **Reboot** 重新启动。

![首次启动欢迎界面](assets/centos/22.png)

此界面是首次进入操作系统时的欢迎界面，点击 **Forward** 根据向导进行一些系统配置。

![防火墙](assets/centos/23.png)

此界面用来配置防火墙，保持默认值，点击 **Forward** 进入下一步。

![SELinux](assets/centos/24.png)

此界面配置 SELinux，即 Linux 安全增强。因为安装 Oracle 需要对系统底层参数进行修改，因此这里把 SELinux 设置为 `Permissive`，点击 **Forward** 进入下一步。

![设置时间](assets/centos/25.png)

此界面用来设置系统时间，通常系统时间都是从硬件时钟获取的，因此请保证系统硬件时间正确。通常这里保持默认即可，点击 **Forward** 进入下一步。

![创建账号](assets/centos/26.png)

此界面用来创建除 root 帐号以外的其他账号，我们暂时不需要其他账号，这里所有文本框留空，直接点击 **Forward** 进入下一步。

![警告](assets/centos/27.png)

因为我们在前面一步没有配置任何个人账号，因此系统提示强烈建议创建一个，不过我们在这里任然继续，点击 **Continue** 进入下一步。

![声卡设置](assets/centos/28.png)

此界面用来配置声卡，如果服务器上配置有操作系统能够识别的声卡就会出现此界面，通常保留默认值即可，点击 **Forward** 进入下一步。

![额外安装](assets/centos/29.png)

此界面让用户插入额外软件的安装光盘，这里我们不需要安装任何额外的软件，直接点击 **Finish**。

![登录界面](assets/centos/30.png)

配置完成以后，系统进入登录界面。

![桌面](assets/centos/31.png)

输入 root 账户和密码，进入桌面。

至此 CentOS Linux 5 安装完成。
