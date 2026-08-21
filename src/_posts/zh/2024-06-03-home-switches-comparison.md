---
layout: lab-post
title: 家用小型管理交换机对比
lang: zh
slug: home-switches-comparison
redirect_from:
  - /zh/home-switch-comparison
  - /zh/home-switch-comparison/
modified_date: 2024-09-11
---

需求是 VLAN 单线复用，不用 IPTV 但需要把弱电箱里的网口通过一根线交换到另一个房间的路由上，同时兼顾拨号。千兆交换够用，也是考虑到目前更高带宽设备的普及度和性价比后的一个更实际的选择。

按说通过配置电信的光猫可以完成这一需求，但配好后 PPPOE 会定时掉线，同时光猫的 DHCP 似乎没办法彻底关闭，关掉后 LAN 口上的设备有时还是会被分到 IP，像是电信的某种检测机制的结果，工作人员来换过一个光猫，但不解决问题，细节他们也不清楚，于是我决定不依赖外部不可控设备[^gm]，在弱电箱里再加一个交换机来实现。

## [水星 SG105 Pro][M5]

常见品牌里比较便宜的一款管理型交换机，配置 UI 很简陋，比如 IGMP Snooping 只有开、关，Link Aggregation 没有模式或协议的选择，没有独立文档、不过 UI 上有简单一两句话的文字帮助，另外我发现这是我唯一一个不支持英文 UI 的网络设备。

![管理后台截图1]({% link /assets/sg105-ui-1.png %})

![管理后台截图2]({% link /assets/sg105-ui-2.png %})

虽然 UI 不算好用但好在不复杂，简单配置后很快能按预期工作了。但我在管理后台的统计中发现一些「失败收包」，比例不高，大约六秒一个，同期对端的设备上没有任何丢包或错误。通过交换网线和端口排除掉了端口和网线的因素，目前观察到「失败收包」只出现在对端是路由器的端口，而且使用上没有发现明显的网络问题，我尝试调整了 RSTP 和 IGMP Snooping 之类的配置，问题依旧，暂时不打算花时间查下去了。

![管理后台失败收包截图]({% link /assets/sg105-failure.png %})

同样的现象也被网上其他人观察到，有的说影响到了 IPTV[^zh]，还有网友发现只要不配置 hybrid[^hybrid] 端口就不会有失败收包[^tp]，不过 hybrid 是我的需求之一。

我把情况反馈给水星官方技术支持，对方表示如果网络没有问题就不要管，这个问题会反馈修复，但目前没有计划。听语气像是个已知问题，而且有造成网络问题的可能。

我去看了下官方的固件，最新版也是唯一的版本，发布于六年前 `1.0.0 Build 20180515 Rel.60684`，虽然目前没有发现问题[^2]，但我不太相信这个产品将来会发新固件解决任何问题，所以打算换掉。


## [网件 GS105e v2][N5][^v2]

千兆、五口、简单网管——在 spec 上和上一款非常接近的交换机，UI 的结构很相似，我怀疑主控都是相同的。

查看两个机器的拆解([1][teardown1], [2][teardown2]) 同时自己拆机查看，感觉网件整体用料上比较足[^yl]，我也考虑过水星更简单的 PCB 也许会有更低的故障率，不过[网件的手册][ng]上高达两百五十万小时的 MTBF 打消了我的顾虑。

这款交换机：

- 没有 Link Aggregation
- 可以给端口添加描述
- 检测到回环 LED 会同频闪
- 支持开启 DHCP 同时使用备用静态地址
- 线缆测试全选没有 bug
  - 线缆正常连接时不显示距离，检测结果稳定（水星会显示距离[^cb]，但多次测试结果相差有几十米）
- VLAN 配置有防呆
  - 例如从唯一 VLAN 移除某端口前会要求设置端口 PVID
- 能同时支持 802.1p 和 DSCP（水星只能二选一）
- UI 支持英、德、日三国语言
- 内置帮助比较详细，常常需要翻页
- 有 ACL 且登陆没有用户名（单用户系统这么设计很科学）
- 设备发现工具支持 macOS、Linux、Windows
- 支持省电模式（IEEE 802.3az），最大功耗 2.6W
  - 有意思的是水星的包装、说明书和官网都没有任何关于功率的介绍，这竟然合规吗？
  - 实测下来，四口在用的情况下，两个设备均在 1.7 watt 左右

![网件管理后台截图]({% link /assets/gs105-ui.png %})

固件更新方面网件比水星好不少，同样作为在售型号，这款从最初 `v1.2.0.5` 到 `v1.6.0.11` 有过 11 次更新，最近一次在 2021-11-12，看上去是一个官方还在维护的产品。

网件的线缆检测也挺好用，可以检测阻抗不匹配的问题（这个情况水星没有处理[^zk]，结果将十几米的线缆报告成了八十几米），如果不是成品网线，连接端出问题的概率应该会比线材本身大，我的测试结果目前反应最近自己新打的水晶头没问题，但老的被检测出 mismatch[^mis]，等我有机会借到工具，换掉老水晶头，再来更新更换后的检测结果。

![线缆测试结果]({% link /assets/gs105-cable-tester-result.png %})

## 总结
此前我对网件的设备印象不太好——又贵又慢，但这次不同，网件的设备从通电到开始正常工作比水星甚至快一些，另外网件也很好地遵守了各类工业标准，产品质量令人放心，且文档丰富，可能拿水星和它比不太公平，毕竟价格有一定差距，但这次的经验让我刷新了对网件的认知，我很满意。



[^gm]: 光猫对用户来说是个黑盒，可配置项不多，型号、功能也不受控制，有些细节只能依赖电信的工作人员帮忙调整。
[^zh]: [为何交换机划分VLAN后出现失败收包？][1]
[^cb]: 线缆测试原理应该是 TDR (time-domain reflectometer) 类似回声测距，对端开路的情况下才会收到反射，不知道水星如何实现非开路测距的，这个领域不太熟。
[^2]: 有一个现象不知道是否相关：开着 iperf 打满千兆的情况下，同一个端口上的其他流量会被严重阻塞，仿佛永远排不上优先级，关掉 iperf 立刻可解。
[^mis]: 帮助里的定义：Mismatch: There is a mismatch with the cable impedance. Replace the Ethernet cable, and then try again. 除此以外网件还支持：Crosstalk: There is an interpair short on the cable.
[^hybrid]: 一个端口同时承载 tagged 和 untagged 数据包。
[^tp]: 网友使用的是 TPLink 的交换机（硬件版本：`TL-SG2005P 2.0` 软件版本：`1.0.0 Build 20200214 Rel.62282`），考虑到这两品牌的关系以及 UI 和水星一致，同样的操作大概率也适用于水星。
[^zk]: 在同类管理后台更高端型号 [SG124D Pro 的手册][sc] 里有发现「阻抗：网线质量问题」的说明，因此这里也有可能是水星没有检测出阻抗问题。
[^v2]: v1 已经 end-of-life 并且不支持 Web UI，只能通过客户端工具配置。
[^yl]: 一些元件资料，网件：[FPE H40520MN][FPE]、[Bothhand 20PT1024X][20PT1024X]/U&T UTH40C01、[winbond W25Q16JV][W25Q16JV] 水星：[HST-2027DAR][HST-2027DAR]、cFeon QH16B-104HIP、[Realtek RTL8367S][RTL8367S]

[teardown1]: https://youtu.be/wibHqsDoqMw?t=269&utm_source={{ site.utm_source }} "Netgear GS105e Full Teardown Review"
[teardown2]: https://youtu.be/KL85i8kUjZM?t=23&utm_source={{ site.utm_source }} "水星SG105 Pro拆机"
[ng]: https://www.downloads.netgear.com/files/GDC/Plus_Switches/Gigabit_Ethernet_Plus_Switches_DS.pdf?utm_source={{ site.utm_source }}
[sc]: https://service.mercurycom.com.cn/content/pdf/201807/SG124D%20Pro%20V1.0%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C%201.0.1.pdf?utm_source={{ site.utm_source }}
[N5]: https://www.netgear.com/support/product/gs105ev2/?utm_source={{ site.utm_source }}
[M5]: https://www.mercurycom.com.cn/product-339-1.html?utm_source={{ site.utm_source }}
[FPE]: http://www.fpe.com.cn/pdf/100Base-t/8.49-53.pdf?utm_source={{ site.utm_source }}
[20PT1024X]: https://www.bothhandusa.com/datasheets/filter-transformer/10-100-dual-dip/20PT10xx-LF-Series.pdf?utm_source={{ site.utm_source }}
[W25Q16JV]: https://www.winbond.com/hq/product/code-storage-flash-memory/serial-nor-flash/?__locale=en&partNo=W25Q16JV&utm_source={{ site.utm_source }}
[HST-2027DAR]: http://www.group-tek.com/uploads/201705/590a906f0ff58.pdf?utm_source={{ site.utm_source }}
[RTL8367S]: https://www.realtek.com/Product/Index?id=3699&utm_source={{ site.utm_source }}

[1]: https://www.zhihu.com/question/598457620/answer/3007190994?utm_source={{ site.utm_source }}
