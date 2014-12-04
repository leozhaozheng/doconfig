通过设置环境变量 export HISTTIMEFORMAT="%F %T `whoami` " 给history加上时间戳  
  
[root@servyou_web ~]# export HISTTIMEFORMAT="%F %T `whoami` "  
[root@servyou_web ~]# history  |  tail  
 1014  2011-06-22 19:17:29 root    15  2011-06-22 19:13:02 root ./test.sh   
 1015  2011-06-22 19:17:29 root    16  2011-06-22 19:13:02 root vim test.sh   
 1016  2011-06-22 19:17:29 root    17  2011-06-22 19:13:02 root ./test.sh   
 1017  2011-06-22 19:17:29 root    18  2011-06-22 19:13:02 root vim test.sh   
 1018  2011-06-22 19:17:29 root    19  2011-06-22 19:13:02 root ./test.sh   
 1019  2011-06-22 19:17:29 root    20  2011-06-22 19:13:02 root vim test.sh   
 1020  2011-06-22 19:17:29 root    21  2011-06-22 19:13:02 root ./test.sh   
 1021  2011-06-22 19:17:29 root    22  2011-06-22 19:13:02 root vim test.sh   
 1022  2011-06-22 19:25:22 root    22  2011-06-22 19:13:02 root vim test.sh   
 1023  2011-06-22 19:25:28 root history  |  tail  
  
可以看到，历史命令的时间戳已经加上了，但是.bash_history里并没有加上这个时间戳。其实这个时间记录是保存在当前shell进程内存里的，如果你logout并且重新登录的话会发现你上次登录时执行的那些命令的时间戳都为同一个值，即当时logout时的时间。  
  
尽管如此，对于加上screen的bash来说，这个时间戳仍然可以长时间有效的，毕竟只要你的server不重启，screen就不会退出，因而这些时间就能长时间保留。你也可以使用echo 'export HISTTIMEFORMAT="%F %T `whoami` "' >> /etc/profile 然后source一下就OK  



改善 Bash 的命令历史管理功能： Bash 的默认配置会存在一个问题，如果同时打开两个（或两个以上的）控制台，那么在这两个控制台中执行的命令并不会互相分享到 history 中。有的命令历史甚至最终会被覆盖掉。要解决这个问题，可把下列内容添加到 ~/.bashrc 或 ~/.bash_profile 文件中： 
shopt -s histappend 
PROMPT_COMMAND='history -a'
第一句的作用是将命令追加到 history 中。第二句是在显示命令提示符时，保存 history。

设置智能的自动完成功能： 在 Bash 中我们已经可以通过按 Tab 键来享用自动完成的特性。通过下面的设置，则可以使用 Up 和 Down 键来选择命令后所跟的参数。在 .inputrc（如果该文件不存在，则创建一个）中加入下列内容：
"\e[A": history-search-backward
"\e[B": history-search-forward
set show-all-if-ambiguous on
前两句使用 Up 和 Down 在 history 中进行搜索。
后一句是按 Tab 显示自动完成。
如果结合 Ctrl - R，则更加好用。



编辑命令

    Ctrl + a ：移到命令行首
    Ctrl + e ：移到命令行尾
    Ctrl + f ：按字符前移（右向）
    Ctrl + b ：按字符后移（左向）
    Alt + f ：按单词前移（右向）
    Alt + b ：按单词后移（左向）
    Ctrl + xx：在命令行首和光标之间移动
    Ctrl + u ：从光标处删除至命令行首
    Ctrl + k ：从光标处删除至命令行尾
    Ctrl + w ：从光标处删除至字首
    Alt + d ：从光标处删除至字尾
    Ctrl + d ：删除光标处的字符
    Ctrl + h ：删除光标前的字符
    Ctrl + y ：粘贴至光标后
    Alt + c ：从光标处更改为首字母大写的单词
    Alt + u ：从光标处更改为全部大写的单词
    Alt + l ：从光标处更改为全部小写的单词
    Ctrl + t ：交换光标处和之前的字符
    Alt + t ：交换光标处和之前的单词
    Alt + Backspace：与 Ctrl + w 相同类似，分隔符有些差别 [感谢 rezilla 指正]

重新执行命令

    Ctrl + r：逆向搜索命令历史
    Ctrl + g：从历史搜索模式退出
    Ctrl + p：历史中的上一条命令
    Ctrl + n：历史中的下一条命令
    Alt + .：使用上一条命令的最后一个参数

控制命令

    Ctrl + l：清屏
    Ctrl + o：执行当前命令，并选择上一条命令
    Ctrl + s：阻止屏幕输出
    Ctrl + q：允许屏幕输出
    Ctrl + c：终止命令
    Ctrl + z：挂起命令

Bang (!) 命令

    !!：执行上一条命令
    !blah：执行最近的以 blah 开头的命令，如 !ls
    !blah:p：仅打印输出，而不执行
    !$：上一条命令的最后一个参数，与 Alt + . 相同
    !$:p：打印输出 !$ 的内容
    !*：上一条命令的所有参数
    !*:p：打印输出 !* 的内容
    ^blah：删除上一条命令中的 blah
    ^blah^foo：将上一条命令中的 blah 替换为 foo
    ^blah^foo^：将上一条命令中所有的 blah 都替换为 foo

FYI：

1.    以上介绍的大多数 Bash 快捷键仅当在 emacs 编辑模式时有效，若你将 Bash 配置为 vi 编辑模式，那将遵循 vi 的按键绑定。Bash 默认为 emacs 编辑模式。如果你的 Bash 不在 emacs 编辑模式，可通过 set -o emacs 设置。
2.    ^S、^Q、^C、^Z 是由终端设备处理的，可用 stty 命令设置。


重复命令参数 先来看一个例子：
$ mkdir /path/to/exampledir ; cd !$
本例中，第一行命令将创建一个目录，而第二行的命令则转到刚创建的目录。这里，“!$”的作用就是重复前一个命令的参数。事实上，不仅是命令的参数可以重复，命令的选项同样可以。另外，Esc + . 快捷键可以切换这些命令参数或选项。


使用置换
        命令置换 先看例子： du -h -a -c $(find . -name *.conf 2>&-) 注意 $() 中的部分，这将告诉 Bash 运行 find 命令，然后把返回的结果作为 du 的参数。
        进程置换 仍然先看例子： diff <(ps axo comm) <(ssh user@host ps axo comm) 该命令将比较本地系统和远程系统中正在运行的进程。请注意 <() 中的部分。
        xargs 看例： find . -name *.conf -print0 | xargs -0 grep -l -Z mem_limit | xargs -0 -i cp {} {}.bak 该命令将备份当前目录中的所有 .conf 文件。


使用管道 下面是一个简单的使用管道的例子： ps aux | grep init 这里，“|”操作符将 ps aux 的输出重定向给 grep init。 下面还有两个稍微复杂点的例子： ps aux | tee filename | grep init 及： ps aux | tee -a filename | grep init
    将标准输出保存为文件 你可以将命令的标准输出内容保存到一个文件中，举例如下： ps aux > filename 注意其中的“>”符号。 你也可以将这些输出内容追加到一个已存在的文件中： ps aux >> filename 你还可以分割一个较长的行： command1 | command2 | ... | commandN > tempfile1 cat tempfile1 | command1 | command2 | ... | commandN > tempfile2
    标准流：重定向与组合 重定向流的例子： ps aux 2>&1 | grep init 这里的数字代表：
        0：stdin
        1：stdout
        2：sterr
    上面的命令中，“grep init”不仅搜索“ps aux”的标准输出，而且搜索 sterr 输出。

