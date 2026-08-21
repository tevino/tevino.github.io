---
layout: lab-post
title: Home switches comparison
lang: en
slug: home-switches-comparison
redirect_from:
  - /home-switches-comparison
machine_translated: true
---

The requirement is VLAN single-line multiplexing. Although IPTV is not needed, I need to switch the network port in the weak current box to a router in another room through a single line, while also accommodating dial-up. Gigabit switching is adequate and a more practical choice after considering the current popularity and cost effectiveness of higher bandwidth devices.

In theory, this requirement could be met by configuring the telecom optical modem. However, after configuration, PPPOE would disconnect periodically, and the modem's DHCP couldn't be completely turned off. Even after disabling it, devices on the LAN port would sometimes still be assigned IPs, seemingly as a result of some detection mechanism by the telecom company. Service personnel came to replace the modem, but it didn't solve the problem, and they weren't clear on the details. So I decided not to rely on external uncontrollable devices[^gm], and instead add a switch in the weak current box to achieve this.

## [Mercury SG105 Pro][M5]

This is a relatively inexpensive managed switch among common brands. The configuration UI is very basic. For example, IGMP Snooping only has on/off options, Link Aggregation has no mode or protocol selection, and there's no separate documentation. However, the UI does have simple one or two-sentence text help. Additionally, I found this to be my only network device that doesn't support an English UI.

![Management backend screenshot 1]({% link /assets/sg105-ui-1.png %})

![Management backend screenshot 2]({% link /assets/sg105-ui-2.png %})

Although the UI isn't very user-friendly, it's simple enough. After basic configuration, it quickly worked as expected. However, in the management backend statistics, I noticed some "failed packet receptions". The proportion wasn't high, about one every six seconds, and there were no packet losses or errors on the devices at the other end during the same period. By swapping network cables and ports, I ruled out factors related to ports and cables. Currently, I've observed that "failed packet receptions" only occur on ports where the other end is a router, and I haven't noticed any obvious network issues in use. I tried adjusting configurations like RSTP and IGMP Snooping, but the problem persisted. I don't plan to spend more time investigating it for now.

![Management backend failed packet reception screenshot]({% link /assets/sg105-failure.png %})

The same phenomenon has been observed by others online, with some saying it affected IPTV[^zh], and some users found that there would be no failed packet receptions as long as hybrid[^hybrid] ports were not configured[^tp]. However, hybrid is one of my requirements.

I reported the situation to Mercury's official technical support. They said if there were no network problems, I shouldn't worry about it. They said this issue would be reported for fixing, but there were no current plans. From their tone, it seemed like a known issue, and there's a possibility it could cause network problems.

I checked the official firmware, and the latest version is also the only version, released six years ago: `1.0.0 Build 20180515 Rel.60684`. Although I haven't found any problems so far[^2], I don't really believe this product will release new firmware to solve any issues in the future, so I plan to replace it.

## [NETGEAR GS105e v2][N5][^v2]

This switch is very similar to the previous one in terms of specifications - gigabit, five ports, simple management. The UI structure is also very similar, making me suspect they use the same main controller.

After examining teardowns of both devices([1][teardown1], [2][teardown2]) and disassembling them myself, I feel that NETGEAR's overall material quality is better[^yl]. I had considered that Mercury's simpler PCB might have a lower failure rate, but the 2.5 million hour MTBF in [NETGEAR's manual][ng] alleviated my concerns.

This switch:

- Lacks Link Aggregation
- Allows adding descriptions to ports
- Has synchronized LED flashing when a loop is detected
- Supports enabling DHCP while using a backup static address
- Has no bugs in the cable test's "select all" function
  - Doesn't show distance when cable is normally connected, and test results are stable (Mercury shows distance[^cb], but results can vary by tens of meters across multiple tests)
- Has safeguards in VLAN configuration
  - For example, it requires setting the port PVID before removing a port from the only VLAN
- Supports both 802.1p and DSCP simultaneously (Mercury only allows choosing one)
- UI supports English, German, and Japanese
- Has detailed built-in help, often requiring scrolling
- Has ACL and no username for login (a scientifically designed single-user system)
- Device discovery tool supports macOS, Linux, and Windows
- Supports power-saving mode (IEEE 802.3az), with a maximum power consumption of 2.6W
  - Interestingly, Mercury's packaging, manual, and website have no information about power consumption. Is this even compliant?
  - In actual tests, with four ports in use, both devices were around 1.7 watts

![NETGEAR management backend screenshot]({% link /assets/gs105-ui.png %})

NETGEAR is significantly better than Mercury in terms of firmware updates. As a currently sold model, this switch has had 11 updates from the initial `v1.2.0.5` to `v1.6.0.11`, with the most recent on 2021-11-12, indicating it's a product still maintained by the manufacturer.

NETGEAR's cable testing is also quite useful. It can detect impedance mismatch issues (which Mercury doesn't handle[^zk], reporting a 10+ meter cable as 80+ meters). If it's not a pre-made network cable, the probability of connection end issues is likely higher than cable material issues. My test results so far show that my recently crimped RJ45 connectors are fine, but older ones were detected as mismatched[^mis]. When I have the chance to borrow tools and replace the old connectors, I'll update with the new test results.

![Cable test results]({% link /assets/gs105-cable-tester-result.png %})

## Summary
Previously, I had a poor impression of NETGEAR devices—expensive and slow. However, this time was different. The NETGEAR device started working normally even faster than Mercury after powering on. Additionally, NETGEAR adheres well to various industry standards, has reassuring product quality, and provides comprehensive documentation. It might not be entirely fair to compare Mercury with it, given the price difference, but this experience has refreshed my perception of NETGEAR, and I'm very satisfied.



[^gm]: The optical modem is a black box for users, with few configurable options. Its model and functions are also not under user control. Some details can only be adjusted with the help of telecom staff.
[^zh]: [Why do failed packet receptions occur after configuring VLAN on the switch?][1]
[^cb]: The cable testing principle should be similar to TDR (time-domain reflectometer), like echo ranging. Reflection should only be received when the other end is open-circuit. I'm not sure how Mercury implements non-open-circuit distance measurement, as I'm not very familiar with this field.
[^2]: There's one thing that I'm not sure if it's relevant: When running iperf at full gigabit capacity, other traffic on the same port gets severely blocked, as if it can never get priority. Turning off iperf immediately resolves this.
[^mis]: Definition in the help: Mismatch: There is a mismatch with the cable impedance. Replace the Ethernet cable, and then try again. Besides this, NETGEAR also supports: Crosstalk: There is an interpair short on the cable.
[^hybrid]: A port that simultaneously carries tagged and untagged packets.
[^tp]: The user was using a TPLink switch (Hardware version: `TL-SG2005P 2.0` Software version: `1.0.0 Build 20200214 Rel.62282`). Considering the relationship between these two brands and the UI being identical to Mercury's, the same operation is likely applicable to Mercury as well.
[^zk]: In the manual of a higher-end model with similar management backend, [SG124D Pro][sc], there's a description of "Impedance: Cable quality issue". Therefore, it's possible that Mercury simply didn't detect the impedance problem here.
[^v2]: v1 is already end-of-life and doesn't support Web UI, it can only be configured through a client tool.
[^yl]: Some component information, NETGEAR: [FPE H40520MN][FPE], [Bothhand 20PT1024X][20PT1024X]/U&T UTH40C01, [winbond W25Q16JV][W25Q16JV] Mercury: [HST-2027DAR][HST-2027DAR], cFeon QH16B-104HIP, [Realtek RTL8367S][RTL8367S]

[teardown1]: https://youtu.be/wibHqsDoqMw?t=269&utm_source={{ site.utm_source }} "Netgear GS105e Full Teardown Review"
[teardown2]: https://youtu.be/KL85i8kUjZM?t=23&utm_source={{ site.utm_source }} "Mercury SG105 Pro teardown"
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
