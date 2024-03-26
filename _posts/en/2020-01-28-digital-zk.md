---
layout: post
category: lab
title: "A digital approach to Luhmann's zettelkasten (slip box)"
lang: en
date: 2020-01-28 13:37:31
slug: digital-zk
redirect_from:
  - /2020/01/28/digital-zettelkasten/
  - /digital-zettelkasten
  - /digital-zettelkasten/
---

**This post is a part of [The Zettelkasten Manual][zk_m]**.

---

This article assumes the reader knows about Luhmann's Zettelkasten, for those who don't, read [this][intro] first.

Here's my digital approach to Luhmann's paper-based filing system in a modern(hopefully better) way, it tries to keep the benefits of the original approach like productivity gain and a solid accumulation of knowledge, the changes happen in the following three levels.

- Physical level
- Logical level
- Slip level


It is recommended to get to know Luhmann’s slip box before reading the content below.

### Physical level

| Paper                    | Digital                                | Purpose                                                                          |
|:-------------------------|:---------------------------------------|:----------------------------------------------------------------------------------|
| Hand-written Paper Slips | Plain text files                       | To last a lifetime                                                               |
| Wooden Box               | A folder encapsulating the above files | To last a lifetime, to store the slips and make it easy to find them for a human |

#### Why plain text

Plain text files could be read and write by a wild range of applications after decades, while specifications of many other formats may changed a lot that your precious files created by an older version of the application are unable to be opened by the new version, or even worse, the application or format just cease to exist.

#### Folder form

A folder could be in any form, as long as it serves the purpose - To store the slips and make it easy to find them for a human.
A simple folder on the file system is fine, if you are using DEVONthink [^4] like me, a folder in it (which does not result in a single folder on the file system) works too.


### Logical level

| Aspect                 | Paper                                                  | Digital                                                                   | Purpose                                               |
|:-----------------------|:-------------------------------------------------------|:--------------------------------------------------------------------------|:------------------------------------------------------|
| Numbering System       | At the top-left of slips e.g. `1/1b2c`                 | The file name and prefix of the title of plaintext files e.g. `1.0b2c.md` | An unique ID for every slip, and visual aid for human |
| References among Slips | ID of the slip to be referenced written on other slips | Markdown links of the slip to be referenced in other slips                | The key to keep relationships between slips           |

#### Numbering system

Unlike other digital approaches [^5] [^6] that use a timestamp to name the slip, I choose to keep Luhmann's way of numbering for two reasons:

1. The timestamp is too long for a person to remember, thus failed to serve the purpose of a visual aid, which I regarded as a crucial help for one to make links manually.
    - However, the creation time of the slip could still be kept in the file.
2. The sequence level of slips are obvious on the list of files in a folder sorted by name
    - So one can navigate easily between adjacent sequence levels, which is likely to be very close to the paper-based workflow done by Luhmann where slips stored together are close in sequence.

There are two tiny changes to Luhmann's approach:

1. **Use `.` instead of `/`**
    - The character `/` is not allowed in a file name for most file systems
2. Use `1.0.md` instead of `1.md` for the first slip of every top-level subject
    - In this way, a normal sort by name could make the first slip(`1.0.md`) ordered before all other slips(e.g. `1.1`, `1.2a`, `1.3b`) instead of after


#### References

**The following markup works with DEVONthink[^4], for those who don't use it, just make sure the application (e.g. a markdown editor) of your choice is capable to jump between files and use the supported markup to create a reference.**


References should be written in explicit form:

```
This is a link to a slip [[1.0]]

This is a link to a slip [1.0](1.0)
```

Implicit form like below doesn't provide a visual aid for the ID of slips:

```
This link doesn't tell the ID of [the slip](1.0) to be referenced

This link doesn't tell the ID of [the slip](1.0) to be referenced
```

### Slip level

A slip is a simple Markdown file, here is an example of `1.0.md`:

```markdown
---
Date: 2019-12-31 11:07:38
---

# 1.0 This is the title of the slip

The content of the slip goes here.

This is an example of a reference to another slip [[1.10a]]

This is an example of citation [1]


---

1. Here sits the bibliography
```


Beside the ordinary slips, there are three special kinds of slips in Luhmann's collection.

| Kind         | Paper                                                                          | Digital                                                             |
|:-------------|:-------------------------------------------------------------------------------|:--------------------------------------------------------------------|
| Contents     | A slip contains a list of references to top-level subjects                     | A single file contains links to top-level slips                     |
| Index        | A slip contains major subjects with references to related slips                | A single file contains links of different subjects to related slips |
| Bibliography | A slip contains bibliographic information of literatures sorted alphabetically | bibliographic information embedded at the bottom of every file      |


#### Auto generation

`Contents` could be automatically generated by scanning the entire slip box folder, but Index is mean to be created manually.

#### Bibliography

Bibliographic information is rather tedious for a human to write multiple times on paper, but it's not a problem in the digital world with the help of applications like Zotero.

By embedding it in every single slip, the slip becomes more self-contained.

## Takeaways

- The **selective** links between cards made it possible to retrieve more than what was intended when the notes were initially taken [^3]
	- That's why the slip box can "communicate" with human, for:
		1. One of the basic presuppositions of communication is that the partners can mutually suprise each other  [^7]
		2. We have been educated to expect something useful from our activities [^8]
- **Without writing, there is no sophisticated thinking**, since both short and long term memory of human brain are limited [^7]
- The system reflects not only validated knowledge but also the **thought process(via the linking)**, including potential mistakes and blind alleys that were later revised but **NOT** removed from the files, instead, a new card with revision may be added if needed [^3]


For a deeper understanding of Zettelkasten, check out [The Zettelkasten Manual][zk_m].

---

[^3]: Schmidt, Johannes F. K. “Niklas Luhmann’s Card Index: The Fabrication of Serendipity.” Sociologica, vol. Vol 12, July 2018, pp. 53-60 Pages. DOI.org (Datacite), doi:10.6092/ISSN.1971-8853/8350.
[^4]: DEVONthink. DEVONtechnologies, LLC, https://www.devontechnologies.com/apps/devonthink.
[^5]: Schallner, Rene. Renerocksai/Sublime_zk. 2017. 2019. GitHub, https://github.com/renerocksai/sublime_zk.
[^6]: Tietze, Christian. The Archive (MacOS) • Zettelkasten Method. https://zettelkasten.de/the-archive/. Accessed 31 Dec. 2019.
[^7]: Niklas, Luhmann. Communicating with Slip Boxes by Niklas Luhmann. http://luhmann.surge.sh/communicating-with-slip-boxes. Accessed 27 Dec. 2019.
[^8]: Luhmann, Niklas. Learning How to Read by Niklas Luhmann. http://luhmann.surge.sh/learning-how-to-read. Accessed 27 Dec. 2019.
[^9]: Luhmann, Niklas. Bibliographie 1. Universitätsbibliothek Bielefeld, 1 June 2017, http://ds.ub.uni-bielefeld.de/viewer/ppnresolver?id=ZL1Bibliographie1. Card Index Box.
[^10]: Luhmann, Niklas. Bibliographie 2. Universitätsbibliothek Bielefeld, 1 June 2017, http://ds.ub.uni-bielefeld.de/viewer/piresolver?id=ZL1Bibliographie2. Card Index Box.


[zk_m]: https://thezettelkasten.com
[intro]: {% post_url en/2020-08-12-zk %}
