---
layout: post
title: "A digital approach to Luhmann’s Zettelkasten (Slip Box)"
date: 2020-01-28 13:37:31
redirect_from:
  - /2020/01/28/digital-zettelkasten/
comments: true
---

- **Updated 2020-08-12**
    - Added link to [Zettelkasten Early Adopters][zk_eas]
    - Put the introduction of Zettelkasten at the beginning

---

## What is it?

Zettelkasten is a non-linear note filling system used by Niklas Luhmann(see below), which resulted in a communication partner or so-called “second brain” of him.

`Zettelkasten` is a German word, `Zettel` means note or slip of paper, `Kasten` indicates box, a Zettelkasten is a box of notes thus `Slip box` in English.

Luhmann’s slip box is a collection(actually he had two collections) of hand-written slips internally connected by references, very much like the hyperlinking of the World Wide Web invented in the late 1980s [1] but happened on paper instead of the Internet back to the 1950s.

While it’s very close to a personal wiki in form, but how these two are created and what they are capable of are fundamentally different, a Zettelkasten could be implemented by a wiki, but a wiki doesn't have to be a Zettelkasten, most of them are not.


### Facts about Niklas Luhmann

- He was a professor of Sociology at the Bielefeld University for 25 years (1968 - 1993)

- Since the 1960s he published articles and books **more than 500 titles on diverse topics**

Here is his answer to his unprecedented productivity in an interview (1987, 142-3) [2] (German translated)

> I don’t think everything on my own, mostly happens in the slip box.
>
> ...
>
> My productivity can essentially be explained from the slip box system.
>
> ...
>
> The slip box costs me more time than writing a book.


### Niklas Luhmann's Slip Box

Simply put, Niklas Luhmann kept notes on small papers stored in a wooden box, and that’s it.

![Zettelkasten][Zettelkasten Photo]

Photo of “Zettelkasten” from [“Niklas Luhmann-Archiv”][Niklas Luhmann-Archiv] is licensed under [CC-BY-NC-SA 4.0][CC-BY-NC-SA 4.0].


There are many good writings [3] and materials [9] [10] about Niklas Luhmann’s slip box. You may read [3] to get to know what it is before further reading, here are some facts about it.


- Two collections in total
- 90,000 handwritten cards in A6 format
- Cards are numbered consecutively
- The notes are not simply excerpts, it consists of his thoughts, theoretical arguments, and concepts

- The first collection was created when he is a legal expert with interests in constitutional law and administrative sciences to a systems theoretical sociologist
- Just before(1960 - 1961) he created the second collection, he spent a year at the Harvard School of Public Administration in Cambridge, MA(USA), where he attended lectures by Talcott Parsons, the leading sociologist in the field of systems theory at the time

- There were no documents in the literary estate substantiating the claim that his visit to Harvard was the trigger to start a new collection of notes, but it seems obvious



|                         | First Collection             | Second Collection                             |
|-------------------------|------------------------------|-----------------------------------------------|
| Created                 | 1951 - 1962                  | 1963 - 1997                                   |
| Handwritten Cards       | 23,000                       | 67,000                                        |
| Content                 | His readings in political science, administrative studies, organization theory, philosophy, and sociology                                           | sociology                                     |
| # of Top-level Sections | 108                          | 11                                            |
| Top-level sections      | state, equality, planning, power, constitution, revolution, hierarchy, science, role, concept of world, information, etc | organizational theory, functionalism, decision theory, office, formal/informal order, sovereignty/state, individual concepts/individual problems, economy, ad hoc notes, archaic societies, advanced civilizations |
| # of Subsections        |                              | 100                                           |
| Section Separator       | a comma: ,                   | a slash /                                     |
| Bibliographies.         | two, containing 2,000 titles | one, incomplete, containing 15,000 references |
| Keyword Index           | 1,250 entries                | 3,200 entries                                 |
| # of References         | 20,000                       | 30,000                                        |
| Average References      | nearly every card has a ref  | nearly every second card has a ref            |



## The digital approach

Here's my digital approach to Luhmann's paper-based filing system in a modern(hopefully better) way, it tries to keep the benefits of the original approach like productivity gain and a solid accumulation of knowledge, the changes happen in the following three levels.

- Physical level
- Logical level
- Slip level


It is recommended to get to know Luhmann’s slip box before reading the content below.

### Physical Level

| Paper                    | Digital                                | Purpose                                                                          |
|:-------------------------|:---------------------------------------|:----------------------------------------------------------------------------------|
| Hand-written Paper Slips | Plain text files                       | To last a lifetime                                                               |
| Wooden Box               | A folder encapsulating the above files | To last a lifetime, to store the slips and make it easy to find them for a human |

#### Why plain text

Plain text files could be read and write by a wild range of applications after decades, while specifications of many other formats may changed a lot that your precious files created by an older version of the application are unable to be opened by the new version, or even worse, the application or format just cease to exist.

#### Folder form

A folder could be in any form, as long as it serves the purpose - To store the slips and make it easy to find them for a human.
A simple folder on the file system is fine, if you are using DEVONthink [4] like me, a folder in it (which does not result in a single folder on the file system) works too.


### Logical Level

| Aspect                 | Paper                                                  | Digital                                                                   | Purpose                                               |
|:-----------------------|:-------------------------------------------------------|:--------------------------------------------------------------------------|:------------------------------------------------------|
| Numbering System       | At the top-left of slips e.g. `1/1b2c`                 | The file name and prefix of the title of plaintext files e.g. `1.0b2c.md` | An unique ID for every slip, and visual aid for human |
| References among Slips | ID of the slip to be referenced written on other slips | Markdown links of the slip to be referenced in other slips                | The key to keep relationships between slips           |

#### Numbering System

Unlike other digital approaches [5] [6] that use a timestamp to name the slip, I choose to keep Luhmann's way of numbering for two reasons:

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

**The following markup works with DEVONthink [4], for those who don't use it, just make sure the application (e.g. a markdown editor) of your choice is capable to jump between files and use the supported markup to create a reference.**


References should be written in explicit form:

> `This is a link to a slip [[1.0]]`
> 
> This is a link to a slip [1.0](1.0)

Implicit form like below doesn't provide a visual aid for the ID of slips:

> `This link doesn't tell the ID of [the slip](1.0) to be referenced`
> 
> This link doesn't tell the ID of [the slip](1.0) to be referenced

### Slip Level

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

- The **selective** links between cards made it possible to retrieve more than what was intended when the notes were initially taken [3]
	- That's why the slip box can "communicate" with human, for:
		1. One of the basic presuppositions of communication is that the partners can mutually suprise each other  [7]
		2. We have been educated to expect something useful from our activities [8]
- **Without writing, there is no sophisticated thinking**, since both short and long term memory of human brain are limited [7]
- The system reflects not only validated knowledge but also the **thought process(via the linking)**, including potential mistakes and blind alleys that were later revised but **NOT** removed from the files, instead, a new card with revision may be added if needed [3]


To know more about best practice on Zettelkasten, subscribe to the [Zettelkasten Early Adopters][zk_eas], I'll share more with you when there're enough subscribers.

---

1. Berners-Lee, Tim. The Original Proposal of the WWW, HTMLized. Mar. 1989, https://www.w3.org/History/1989/proposal.html.
2. Schmidt, Johannes F. K. “Der Nachlass Niklas Luhmanns – eine erste Sichtung: Zettelkasten und Manuskripte.” Soziale Systeme, vol. 19, no. 1, Jan. 2014. DOI.org (Crossref), doi:10.1515/sosys-2014-0111.
3. Schmidt, Johannes F. K. “Niklas Luhmann’s Card Index: The Fabrication of Serendipity.” Sociologica, vol. Vol 12, July 2018, pp. 53-60 Pages. DOI.org (Datacite), doi:10.6092/ISSN.1971-8853/8350.
4. DEVONthink. DEVONtechnologies, LLC, https://www.devontechnologies.com/apps/devonthink. 
5. Schallner, Rene. Renerocksai/Sublime_zk. 2017. 2019. GitHub, https://github.com/renerocksai/sublime_zk.
6. Tietze, Christian. The Archive (MacOS) • Zettelkasten Method. https://zettelkasten.de/the-archive/. Accessed 31 Dec. 2019.
7. Niklas, Luhmann. Communicating with Slip Boxes by Niklas Luhmann. http://luhmann.surge.sh/communicating-with-slip-boxes. Accessed 27 Dec. 2019.
8. Luhmann, Niklas. Learning How to Read by Niklas Luhmann. http://luhmann.surge.sh/learning-how-to-read. Accessed 27 Dec. 2019.
9. Luhmann, Niklas. Bibliographie 1. Universitätsbibliothek Bielefeld, 1 June 2017, http://ds.ub.uni-bielefeld.de/viewer/ppnresolver?id=ZL1Bibliographie1. Card Index Box.
10. Luhmann, Niklas. Bibliographie 2. Universitätsbibliothek Bielefeld, 1 June 2017, http://ds.ub.uni-bielefeld.de/viewer/piresolver?id=ZL1Bibliographie2. Card Index Box.



[Zettelkasten Photo]: /assets/zettelkasten.jpg
[Niklas Luhmann-Archiv]: https://niklas-luhmann-archiv.de/bestand
[CC-BY-NC-SA 4.0]: https://creativecommons.org/licenses/by-nc-sa/4.0/
[zk_eas]: http://eepurl.com/haGi4D

