---
layout: post
category: blog
title: "我如何管理了 12 年的笔记"
date: 2024-08-23
lang: zh
slug: notes-over-12-years
machine_translated: true
---

我有一个从2012年开始的Git仓库。在那之前，我记得使用Notational Velocity[^5]和一堆文本文件，它运行得很好，直到我决定将我的笔记保留一辈子。如果我没有将它们数字化，我会在索引卡上写笔记，并将它们存放在盒子里进行组织。只要我能保存这些盒子，我就能保留我的笔记。

对于数字笔记，文件可以用作索引卡，文件夹可以用作盒子，因此保持文件夹的安全就足够了吗？是也不是，确实，只要文件夹和文件安全，笔记就安全，但能否阅读文件内容取决于文件的格式。例如，如果你将笔记放在一个在线服务（例如[Notion][notion]）上，或本地存储但使用只有特定应用程序（如[OneNote][onenote]）能查看和编辑的格式。由于你的笔记很可能比那些云服务和应用程序存在时间更长，当它们被停用时，你将面临危机，[更多内容在这里][data-format]。结论是：使用像纯文本(.txt)这样的简单格式来保障你的笔记的未来。

保持数字笔记“安全”也比听起来要困难。存在[位损坏][bit_rot]等问题，正确备份也很难做到。在数字形式下，修改比在物理形式下要容易得多，以至于在你没有意识到的情况下可能发生意外更改。我曾经遇到过文件在误删某些或全部内容后被保存或自动保存的情况。更糟的是，我通常是在几天或几个月后重新访问文件时才发现这些问题，那时撤销更改或从备份恢复已经不再可能。

使用云存储或同步服务，情况会更糟。同步可能随时发生，并且可能发生无数次。每次同步时，不可避免的冲突都有机会混入——就像一群看不见的顽皮孩子随意打开我的笔记盒子，在上面涂鸦，或将它们折成飞机飞走。当我发现涂鸦或缺失的笔记时，唯一的方法就是逐一打开每个文件，逐行检查——谢谢，但我不愿意这样做。

隐私是云存储的一个主要问题。作为从业人员，我对这方面了解得过多。人们可能认为大公司处理这一方面很好，但实际情况往往并非如此。大公司拥有更多的网络安全资源和额外的保护用户隐私的努力。然而，它们也是攻击者的更具吸引力的目标，攻击面更大，意味着可能出现更多问题。这就是为什么我不使用基于云的[1Password][1pass]，尽管它的用户体验非常出色。同样，我也不希望看到我的多年思考过程和日记出现在公共数据泄露事件中。

自托管的Git仓库对我来说效果很好，它记录了每一次更改的历史，保持了我在各设备上笔记的一致版本，我不必担心我的笔记被用于训练任何模型。然而，这绝对不是适合所有人的解决方案，尤其是那些不熟悉Git的人。

## 仓库

这个仓库有过很多名字，“卡片盒”、“可视化Zettelkasten”、“子弹笔记”和“笔记”。每个名字代表了我使用它的一个“时代”，下面是从过去到现在的时间线。

### 卡片盒

这是仓库的起点，那时我使用文件和文件夹来模拟包含笔记卡片的物理盒子——就像Niklas Luhmann组织他的手写笔记一样，我在[这里写了更多细节][dzk]。简而言之：一系列互相链接的文本文件，形成一个反映我思维过程的网络。

### 可视化Zettelkasten

随着我创建越来越多的文件，我开始编写脚本来使用[Graphviz][graphviz]可视化它们，并使用Gollum[^1]作为查看器和编辑器。为了更方便地添加新笔记，我向项目贡献了_上下文感知模板过滤器_[^2][^3]。最后，我将所有内容集成到一个单一的Web应用程序中，这对我来说效果很好。每个阶段的实现都与我的笔记一起进行版本控制，因此每当我“回溯历史”时，总是可以得到正确的可视化效果。

### 子弹笔记

它来源于Ryder Carroll的《子弹日志方法》一书。书中建议使用简单的子弹符号和少量符号进行快速记事，并提出了组织这些子弹的系统，包括索引、每月回顾、年度迁移等。结果的日志看起来非常类似于柳比歇夫的。自从使用子弹日志方法以来，我发现自己比以前更频繁地记录日记。

我为我的日记创建了一个新的仓库，这原本不是我笔记的一部分。我记得因为其子弹导向的特性而使用了[LogSeq][logseq]，但后来发现其性能和稳定性问题令人困扰。我放弃使用LogSeq的主要原因是它“发明了”仅在LogSeq中有效的Markdown标记，且可读性不是优先考虑的。换句话说，虽然笔记是Markdown格式，但内容并未设计为不依赖应用程序进行阅读和编辑。我停止使用LogSeq，并开始考虑与现有笔记合并。

### 笔记

我发现通过链接我的日记和笔记，我可以更好地保留我的思维背景。日记通常是一个想法的起点，然后它会变成一系列笔记；有时类似的想法不断出现，共享相同的起源。我从Day One Classic[^4]导入了我的“传统”长篇日记，以及一些来自[DEVONthink][dt]的笔记，然后与现有笔记合并。现在我有了一个包含笔记和日记的单一仓库。

[Obsidian][obsidian]与[Git插件][obgit]是我目前处理仓库的选择。它的图表视图取代了我自己的可视化效果。在移动设备上使用Git很具挑战性，即使使用了[Working Copy][workingcopy]和快捷指令，我还是创建了[Voice Inbox][vb]。

## 思考

如果我没有坚持使用纯文本，我会发现自己在物理和数字形式之间痛苦地切换，转换专有文件格式，迁移应用程序和服务。我可能最终会选择像Apple Notes这样简单的工具，但我不会满意，因为没有简单的导入或导出方式。

我也使用其他不支持本地纯文本存储的在线服务和离线应用程序，但仅作为黑板——我暂时使用它们来思考或组织，然后擦除一切——最终内容会如果有必要，转移到我自己的仓库。我设计了[Voice Inbox][vb]以类似方式使用——作为一个捕捉工具——内容放进去，但结果存储在你自己的仓库中。这不是一个永久存储，而是一个方便的编辑器。

我仍然使用 [DEVONthink][dt]、Visual Studio Code、Vim 和其他命令行工具来处理我的笔记。对我来说，它们与 Obsidian 并没有太大的区别。每一个工具在特定情况下都可以是最佳选择。要求其中任何一个工具满足我所有的需求，同时还不包含我不需要的功能和偏好，是不切实际的。因此，我根据每项任务的需要选用最合适的工具。即使有一天这些工具中的任何一个不复存在，我也不会受到影响。这就是拥有自己数据的美妙之处：仓库是数据存储的地方，也是唯一重要的东西。应用程序仅仅是我用来处理笔记的查看器和编辑器。它们的寿命可能不如我的数据那么长，但这没关系。

---

[obsidian]: https://obsidian.md?utm_source={{ site.utm_source }}
[notion]: https://notion.so?utm_source={{ site.utm_source }}
[onenote]: https://onenote.com?utm_source={{ site.utm_source }}
[1pass]: https://1password.com?utm_source={{ site.utm_source }}
[data-format]: {% post_url zh/2023-07-25-data %}
[graphviz]: https://graphviz.org?utm_source={{ site.utm_source }}
[workingcopy]: https://workingcopy.app?utm_source={{ site.utm_source }}
[vb]: https://voiceinbox.com?utm_source={{ site.utm_source }}
[logseq]: https://logseq.com?utm_source={{ site.utm_source }}
[bit_rot]: https://en.wikipedia.org/wiki/Data_degradation?utm_source={{ site.utm_source }}
[dt]: https://devontechnologies.com/apps/devonthink?utm_source={{ site.utm_source }}
[dzk]: {% post_url zh/2020-01-28-digital-zk %}
[obgit]: https://github.com/Vinzent03/obsidian-git?utm_source={{ site.utm_source }}

[^1]: 驱动 GitHub 项目 wiki 页面的项目：[GitHub - gollum/gollum: A simple, Git-powered wiki with a local frontend and support for many kinds of markup and content.][1]
[^2]: [Context-aware template filter · gollum/gollum Wiki · GitHub][2]
[^3]: [Add page context to template filter, resolves #1603 by tevino · Pull Request #1818 · gollum/gollum · GitHub][3]
[^4]: 离线版 [Day One][4]
[^5]: [Notational Velocity][5] 是一个让我快速搜索和切换文件的文本编辑器。后来我转用了[nvALT][6]，这是Notational Velocity的一个分支，增加了一些额外功能和界面修改，包括MultiMarkdown功能。

[1]: https://github.com/gollum/gollum?utm_source={{ site.utm_source }}
[2]: https://github.com/gollum/gollum/wiki?utm_source={{ site.utm_source }}#context-aware-template-filter
[3]: https://github.com/gollum/gollum/pull/1818?utm_source={{ site.utm_source }}
[4]: https://dayoneapp.com?utm_source={{ site.utm_source }}
[5]: https://notational.net?utm_source={{ site.utm_source }}
[6]: https://brettterpstra.com/projects/nvalt/?utm_source={{ site.utm_source }}
