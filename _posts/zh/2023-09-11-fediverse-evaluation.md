---
layout: lab-post
title: 联邦宇宙平台评估
lang: zh
slug: fediverse-evaluation
meta:
  - name: Mastodon
    description: v4.2.0
  - name: GoToSocial  
    description: v0.11.1 git-c7a46e0
  - name: Pleroma
    description: v2.5.5
  - name: Firefish
    description: v1.1.0-dev2  
machine_translated: true
---

随着推特变成又一个抖音并加大了对内容的控制[^tb] [^shit],我开始使用联邦宇宙作为替代品。

现在是加入联邦宇宙的好时机,因为自我上次尝试以来,它已经成熟了。

得益于马斯克 :) 联邦宇宙用户基数已超过 1200 万。

[![联邦宇宙总用户数量](/assets/2023-10_fediverse_users.png "联邦宇宙总用户数量")][fedi_users]
[![Mastodon 总用户数量和活跃用户数量](/assets/2023-10_mastodon_users.png "Mastodon 总用户数量和活跃用户数量")][mas_users]


然而,由于联邦宇宙的去中心化特性,加入它并不像加入推特那么简单。 有许多平台可供选择,类似于 Gmail 之类的电子邮件提供商。

本文描述了我为自己选择平台的过程。

## 需求

就用户和平台(提供商)的关系而言,联邦宇宙目前的工作方式类似于电子邮件。

如果一个平台宕机,你的账户也会消失。帐户迁移是通过 [重定向][single] 实现的,如果原始平台关闭,迁移是不可能的。

最糟糕的是,除了 Calckey(下文详述)之外,几乎所有平台都不支持内容迁移。

我们不得不面对现实——如果推特能失败,联邦宇宙服务器[^small]也一样。自我托管可以让我完全控制自己的数据[^data1] [^data2],减少我生活中的依赖[^ti]。

凭借我的技术背景,我有能力进行自托管。 对于其他人来说,加入一个实例/服务器仍比留在大平台上好。

有这么多实现可供选择,我的需求如下:

1. 内容迁出(而不是迁入)
2. 多语言发帖支持,这样我和关注者可以订阅某些语言
3. 跨平台关注人员 
4. 发帖和编辑
5. 用 Unicode 搜索我和关注者的帖子
6. 通过标签搜索联合内容
7. 低资源占用以实现可持续发展[^resource]

## 评估

### GoToSocial

考虑到单人服务器的设计,无需外部服务——完美契合我的案例。

鉴于轻量级的资源占用,它的运行很好。

像 [elk][elk] 这样的前端允许在发帖时选择语言,但这在服务器之间传播[失败][gts_bug],因此 Mastodon 实例无法识别语言首选项。

缓慢的开发和长期存在的错误,比如多语言问题,让人担忧。

非常有前途,但对我来说还不够成熟投入生产。

### Pleroma

与 GoToSocial 类似,考虑到单用户使用案例而设计,但更成熟、更受欢迎。
鉴于提供的丰富功能,资源占用很轻。官方部署指南面向的是源代码和开发人员。
我喜欢对 Gopher 的支持。

我观察到一些帖子在其他实例的关注者时间线上丢失,即使他们直接访问我的个人资料。 丢失的帖子在我自己的时间线上确实存在且是公开的,并且在丢失帖子的前后都有可见的帖子。

贡献者实现了多语言发帖支持,但被作者[拒绝合并][pleroma_mr],因为担心复杂性:

> 很抱歉,我本该早点说的,但我不认为合并这个是明智之举。 这是 2000 多行新的代码,涉及代码库的那么多方面,为一个看起来用处不大的功能。
>
> 代码本身看起来不错,但由于复杂性原因,我寻思着最好不要把这个功能放入 pleroma 主线。

看起来短期内不太可能被添加。

### Akko
一个带有翻译功能且快速开发的 Pleroma 分支。
然而,单用户场景不再是首要任务。

### Calckey/Firefish

内容迁移吸引了我。

我成功从 Mastodon 和 Pleroma 导入了备份(其他平台不支持),导入期间帖子标题遗失了但基本没问题。

他们的旗舰实例最近经历了崩溃和与迁移相关的问题(来自公告):

- 一个月前:服务器崩溃并修复
- 一周前:一些用户的主页时间线由于迁移出现错误


目前感觉非常实验性。


### Mastodon

这是我一开始就要避免的,因为它的资源占用非常激进。

除此之外,它满足我的所有要求,具有出色的多语言支持——帖子可以用语言标签标记,这样观众可以通过标签订阅/过滤内容,从而只查看您说的语言。

## 决定

尽管资源占用大,但我最终选择了 Mastodon,因为它是唯一同时支持发帖和阅读多语言的平台。
而且作为受支持程度最高的联邦宇宙平台,它最有可能获得未来的内容迁移功能。

这对我来说还不够理想,所以如果未来有任何平台具备可观的多语言支持,我很乐意尝试。



[^shit]: [An Audacious Plan to Halt the Internet's Enshittification - Cory Doctorow](https://www.youtube.com/watch?v=q118B_QdP2k)
[^tb]: 推特会压制它们不喜欢的内容,例如提及竞争对手 Mastodon 时。
[^data1]: 这是我的一般偏好,这里有一篇[相关文章]({% post_url zh/2023-07-25-data %})。
[^data2]: 我需要用到的旧推文中的链接已经失效,参见[这篇文章](https://www.theverge.com/2023/8/20/23838823/twitter-x-deleted-pictures-links-2014-metadata-t-co-shortener)。
[^small]: 从另一个角度来看,联邦宇宙服务器规模较小,被收购和过载的可能性也更小,但我喜欢有所准备。
[^lang]: 我用英语和中文发帖,一个变通方法是分语言使用独立账号,但根据我的经验需要花太多精力。
[^resource]: 可以在 5 美元的 VPS 上运行。


[single]: https://jvns.ca/blog/2023/08/11/some-notes-on-mastodon/
[pleroma_mr]: https://git.pleroma.social/pleroma/pleroma/-/merge_requests/3822
[gts_bug]: https://github.com/superseriousbusiness/gotosocial/issues/1277 
[ti]: https://sive.rs/ti#why
[elk]: https://elk.zone
[fedi_users]: https://fediverse.observer/stats
[mas_users]: https://mastodon-analytics.com