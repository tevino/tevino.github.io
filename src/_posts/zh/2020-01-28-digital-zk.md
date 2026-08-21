---
layout: post
category: lab
title: "数字化卢曼的卡片盒系统（Zettelkasten）"
lang: zh
date: 2020-01-28 13:37:31
modified_date: 2024-09-11
slug: a-digital-approach-to-luhmanns-zettelkasten-slip-box
machine_translated: true
excerpt_separator: <!--more-->
---

**本文是[卡片盒系统手册][zk_m]的一部分**。

---

本文假设读者已经了解卢曼的卡片盒系统（Zettelkasten），如果不了解，请先阅读[这篇介绍][intro]。

以下是我对卢曼基于纸质的文件系统的数字化方法，希望能以更现代（也许更好）的方式实现。这种方法试图保留原始方法的优点，如提高生产力和积累知识，同时在以下三个层面进行了改变：

- 物理层面
- 逻辑层面
- 卡片层面

<!--more-->
建议在阅读以下内容之前先了解卢曼的卡片盒系统。

### 物理层面

| 纸质                 | 数字化                   | 目的                                           |
|:---------------------|:-------------------------|:-----------------------------------------------|
| 手写纸质卡片         | 纯文本文件               | 持久保存                                       |
| 木制盒子             | 包含上述文件的文件夹     | 持久保存，存储卡片并方便人类查找               |

#### 为什么选择纯文本

纯文本文件可以在几十年后仍被各种应用程序读写，而许多其他格式的规范可能会发生很大变化，导致你用旧版本应用程序创建的珍贵文件无法被新版本打开，更糟糕的是，应用程序或格式可能会完全消失。

#### 文件夹形式

文件夹可以是任何形式，只要能达到目的 - 存储卡片并方便人类查找。
文件系统上的简单文件夹就可以，如果你像我一样使用DEVONthink[^4]，其中的文件夹（不会在文件系统上形成单个文件夹）也可以。

### 逻辑层面

| 方面                 | 纸质                                   | 数字化                                                   | 目的                                   |
|:---------------------|:---------------------------------------|:---------------------------------------------------------|:---------------------------------------|
| 编号系统             | 卡片左上角，如 `1/1b2c`                | 纯文本文件的文件名和标题前缀，如 `1.0b2c.md`             | 为每个卡片提供唯一ID，便于人类视觉识别 |
| 卡片间的引用         | 在其他卡片上写下被引用卡片的ID         | 在其他卡片中使用Markdown链接引用被引用的卡片             | 保持卡片之间关系的关键                 |

#### 编号系统

与其他使用时间戳命名卡片的数字化方法[^5] [^6]不同，我选择保留卢曼的编号方式，原因有二：

1. 时间戳太长，不易记忆，因此无法起到视觉辅助的作用，而我认为这对手动建立链接至关重要。
    - 然而，卡片的创建时间仍可以保存在文件中。
2. 在按名称排序的文件夹中，卡片的序列层级一目了然
    - 因此可以轻松在相邻的序列层级之间导航，这很可能与卢曼在纸质工作流程中将相近序列的卡片存放在一起的做法非常接近。

对卢曼方法有两个小改动：

1. **使用 `.` 代替 `/`**
    - 大多数文件系统不允许在文件名中使用 `/` 字符
2. 对每个顶级主题的第一个卡片使用 `1.0.md` 而不是 `1.md`
    - 这样，按名称正常排序时，第一个卡片（`1.0.md`）会排在所有其他卡片（如 `1.1`、`1.2a`、`1.3b`）之前，而不是之后

#### 引用

**以下标记适用于DEVONthink[^4]，对于不使用它的人，请确保你选择的应用程序（例如markdown编辑器）能够在文件之间跳转，并使用支持的标记创建引用。**


引用应该以显式形式书写：

```
这是一个指向一张卡片的链接 [[1.0]]

这是一个指向一张一张卡片的链接 [1.0](1.0)
```

以下隐式形式无法为卡片的ID提供视觉辅助：

```
这个链接没有显示被引用卡片的ID [卡片](1.0)
```

### 卡片层面

一张卡片是一个简单的 Markdown 文件, 以下是文件 `1.0.md` 的例子:

```markdown
---
Date: 2019-12-31 11:07:38
---

# 1.0 这是卡片的标题

此处是卡片内容.

这是一个引用另一张卡片的例子 [[1.10a]]

这是一个引用文献的例子 [^1]


---

[^1]: 这里是参考文献
```
除了普通的卡片外，卢曼的卡片盒中还有三种特殊类型的卡片。

| 类型     | 纸质                               | 数字化                         |
|:---------|:---------------------------------|:-------------------------------|
| 目录     | 一张卡片包含对顶级主题的引用列表       | 一个文件包含指向顶级卡片的链接      |
| 索引     | 一张卡片包含主要主题及相关卡片的引用    | 一个文件包含不同主题与相关卡片的链接 |
| 参考文献 | 一张卡片按字母顺序排列包含文献的书目信息 | 书目信息嵌入每个文件的底部         |


#### 自动生成

通过扫描整个卡片盒文件夹可以自动生成`目录`，但索引则需要手动创建。

#### 参考文献

对于人类来说，在纸上多次书写书目信息相当繁琐，但在数字世界中，借助Zotero等应用程序，这就不是问题了。

通过将书目信息嵌入每张卡片中，卡片变得更加自包含。

## 要点

- 卡片之间的**选择性**链接使得检索时能够获得比最初记笔记时预期更多的内容 [^3]
    - 这就是为什么卡片盒能够与人"交流"，因为：
        1. 交流的一个基本前提是伙伴之间能够相互带来惊喜 [^7]
        2. 我们已经被教育要期望从我们的活动中得到有用的东西 [^8]
- **没有写作，就没有复杂的思考**，因为人脑的短期和长期记忆都是有限的 [^7]
- 这个系统不仅反映了已验证的知识，还反映了**思考过程（通过链接）**，包括后来被修正的潜在错误和死胡同，这些并**没有**从文件中删除，而是在需要时可能会添加一张带有修订的新卡片 [^3]


要更深入地了解Zettelkasten，请查看[Zettelkasten手册][zk_m]。

---

[^3]: Schmidt, Johannes F. K. “Niklas Luhmann’s Card Index: The Fabrication of Serendipity.” Sociologica, vol. Vol 12, July 2018, pp. 53-60 Pages. DOI.org (Datacite), doi:10.6092/ISSN.1971-8853/8350.
[^4]: [DEVONthink. DEVONtechnologies, LLC][1].
[^5]: [Schallner, Rene. Renerocksai/Sublime_zk. 2017. 2019. GitHub][2].
[^6]: [Tietze, Christian. The Archive (MacOS) • Zettelkasten Method][3]. Accessed 31 Dec. 2019.
[^7]: [Niklas, Luhmann. Communicating with Slip Boxes by Niklas Luhmann][4]. Accessed 27 Dec. 2019.
[^8]: [Luhmann, Niklas. Learning How to Read by Niklas Luhmann][5]. Accessed 27 Dec. 2019.
[^9]: [Luhmann, Niklas. Bibliographie 1. Universitätsbibliothek Bielefeld, 1 June 2017][6]. Card Index Box.
[^10]: [Luhmann, Niklas. Bibliographie 2. Universitätsbibliothek Bielefeld, 1 June 2017][7]. Card Index Box.


[zk_m]: https://thezettelkasten.com?utm_source={{ site.utm_source }}
[intro]: {% post_url en/2020-08-12-zk %}

[1]: https://www.devontechnologies.com/apps/devonthink?utm_source={{ site.utm_source }}
[2]: https://github.com/renerocksai/sublime_zk?utm_source={{ site.utm_source }}
[3]: https://zettelkasten.de/the-archive/?utm_source={{ site.utm_source }}
[4]: http://luhmann.surge.sh/communicating-with-slip-boxes?utm_source={{ site.utm_source }}
[5]: http://luhmann.surge.sh/learning-how-to-read?utm_source={{ site.utm_source }}
[6]: http://ds.ub.uni-bielefeld.de/viewer/ppnresolver?id=ZL1Bibliographie1?utm_source={{ site.utm_source }}
[7]: http://ds.ub.uni-bielefeld.de/viewer/piresolver?id=ZL1Bibliographie2?utm_source={{ site.utm_source }}

