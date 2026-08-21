---
layout: post
category: blog
title: "How I’ve managed notes over 12 years"
lang: en
date: 2024-08-15
slug: notes-over-12-years
redirect_from:
    - /notes-over-12-years
---

I have a Git repository dating back to 2012. Before that, I remember using Notational Velocity[^5] with a bunch of text files, it worked well, until I decided to keep my notes for life. If I’m not digitizing them, I’ll write notes on index cards and store them in boxes for organizing. As long as I can keep the boxes, I get to keep my notes.

For digital notes, files could be used as index cards, and folders as boxes, so it’s as easy as keeping the folders safe, right? Yes and no, it's true that as long as the folders and files are safe, the notes are safe, whether you'll be able to read what's in the files depends on their format. For example, if you put your notes on an online service([Notion][notion] for example) or locally but in a format that only a specific application(such as [OneNote][onenote]) can view and edit. Since your notes will most likely live longer than those cloud services and applications, when they are discontinued, you'll have a crisis, [more on it here][data-format]. The conclusion is: use only simple formats like plain text(.txt) to future-proof your notes.

It's also harder than it sounds to keep digital notes "safe". Issues like [bit rot][bit_rot] exist, and properly backing up is hard to do correctly. In digital form, making changes is much easier than in physical form, it’s so easy that unintended changes might happen without your awareness. I've had instances where my files were saved or auto-saved after an accidental deletion of some or all of the content. What makes this even worse is I only found out after revisiting the file days or months later, when undoing the change or restoring from a backup was no longer possible.

With cloud storage or a syncing service, things get worse. Synchronizations can happen at any time and countless times. Each time, unavoidable conflicts get chances to sneak in—like a group of invisible naughty kids randomly opening my boxes of notes, doodling on them, or folding them into airplanes and flying them away. When I find a doodled or missing note, the only way to check if there’s more is to open every file and check line by line—no thanks.

Privacy is a major concern for cloud storage. Working in the industry has taught me too much about it. People might think big corporations handle this aspect well, but it rarely is the case. A bigger corporation has more resources for cybersecurity and the additional effort required to protect users' privacy. However, it's a more appealing target for attackers with a larger attack surface, meaning there're too many things that could go wrong. This is why I don't use cloud-based [1Password][1pass], despite its top-notch user experience. Similarly, I don't want to see years of my thinking processes and journals in a public data breach.

A self-hosted Git repository has worked well for me, it keeps a history of every change, maintains the same version of my notes across my devices, and I don't have to worry about my notes being used to train any models. Yet, it's definitely not a solution for everyone, especially those who aren't familiar with Git.

## The repository

The repository has had many names, "Card Box", "Visual Zettelkasten" "Bullet Journal", and “Notes”. Each name represents an “era” of how I've use it, below is a timeline from past to present.

### Card Box

This is the start of the repository, a period when I used files and folders to emulate physical boxes containing cards with notes—how Niklas Luhmann organized his handwritten notes, I’ve written [more details here][dzk]. In short: a collection of text files that are interlinked to form a network reflecting my thinking processes.

### Visual Zettelkasten

As I created more and more files, I started writing scripts to visualize them using [Graphviz][graphviz], and used Gollum[^1] as a viewer and editor. To make adding new notes easier, I contributed the _context-aware template filter_[^2][^3] to the project. Finally, I integrated everything into a single web application that worked great for me. The implementation of each stage is version-controlled with my notes, so whenever I "go back in history" I always have the correct visualization.

### Bullet Journal

It's from the book "The Bullet Journal Method" by "Ryder Carroll". It suggests using simple bullets with a small set of notations for quick journaling, and proposes a system to organize those bullets, including indexing, monthly reviews, annual migrations, and etc. The resulting journal looks very similar to Andrey Kolmogorov’s. Ever since the bullet journal method, I find myself journaling more frequently than before.

I created a new repository for my journal, which was not originally part of my notes. I remember using [LogSeq][logseq] with the repository because of its bullet-oriented nature, but later I found the performance and stability issues to be bothersome. The main reason I gave up using LogSeq was that it "invents" markdown markups that only work in LogSeq and human readability was not a priority. In other words, although the notes are in markdown format, the content is not designed to be read and edited without the application. I stopped using LogSeq and began considering a merge with my existing notes.

### Notes

I found that by linking my journals and notes, I could better preserve the context of my thoughts. The journal is usually where an idea starts, and it then blooms into a cluster of notes; sometimes similar ideas that keep popping up share the same origin. I imported my "traditional" long-form diaries from Day One Classic[^4], and some notes from [DEVONthink][dt], then merged them with my existing notes. Now I have a single repository for both my notes and journals.

[Obsidian][obsidian] with [a Git plugin][obgit] is currently my choice for working with the repository. Its graph view has taken replaced my own visualizations. Using Git on mobile is challenging, even with [Working Copy][workingcopy] and Shortcuts, so I created [Voice Inbox][vb].

## Thoughts

If I hadn't stuck to plaintext, I'd find myself painfully switching between physical and digital forms, converting proprietary file formats, migrating among applications, and services. I might eventually settle on something as simple as Apple Notes, but I wouldn't be happy because there's no easy way to import or export.

I also use other online services and offline applications that don’t support local plain text storage, but only as a blackboard—I use them temporarily for thinking or organizing, then erase everything—the finalized content goes to my own repository if necessary. I designed [Voice Inbox][vb] to be used in a similar way—a capturing tool—the content goes into it, but the results are stored in your own repository. It's not a permanent storage but a convenient editor.

I still use applications like [DEVONthink][dt], Visual Studio Code, Vim, and other command-line utilities to work with my notes. To me, they are not that different from Obsidian. Each of them could be the best fit under a certain situation. It's unrealistic to ask any **one** of them to fulfill **all** my requirements while excluding features and preferences that I don't need, so I use whatever works best for each task. If one day any of these tools ceased to exist, I'd be fine. This is the beauty of owning my data: the repository is the data store and the only thing that matters. Applications are merely viewers and editors that I use to work with my notes. They might not live as long as my data, and that's fine.

---

[obsidian]: https://obsidian.md?utm_source={{ site.utm_source }}
[notion]: https://notion.so?utm_source={{ site.utm_source }}
[onenote]: https://onenote.com?utm_source={{ site.utm_source }}
[1pass]: https://1password.com?utm_source={{ site.utm_source }}
[data-format]: {% post_url en/2023-07-25-data %}
[graphviz]: https://graphviz.org?utm_source={{ site.utm_source }}
[workingcopy]: https://workingcopy.app?utm_source={{ site.utm_source }}
[vb]: https://voiceinbox.com?utm_source={{ site.utm_source }}
[logseq]: https://logseq.com?utm_source={{ site.utm_source }}
[bit_rot]: https://en.wikipedia.org/wiki/Data_degradation?utm_source={{ site.utm_source }}
[dt]: https://devontechnologies.com/apps/devonthink?utm_source={{ site.utm_source }}
[dzk]: {% post_url en/2020-01-28-digital-zk %}
[obgit]: https://github.com/Vinzent03/obsidian-git?utm_source={{ site.utm_source }}

[^1]: The project that powered the wiki page of GitHub projects: [GitHub - gollum/gollum: A simple, Git-powered wiki with a local frontend and support for many kinds of markup and content.][1]
[^2]: [Context-aware template filter · gollum/gollum Wiki · GitHub][2]
[^3]: [Add page context to template filter, resolves #1603 by tevino · Pull Request #1818 · gollum/gollum · GitHub][3]
[^4]: The offline version of [Day One][4]
[^5]: [Notational Velocity][5] is a text editor that lets me quickly search and switch between files. Later I switched to [nvALT][6]—a fork of Notational Velocity with some additional features and interface modifications, including MultiMarkdown functionality.

[1]: https://github.com/gollum/gollum?utm_source={{ site.utm_source }}
[2]: https://github.com/gollum/gollum/wiki?utm_source={{ site.utm_source }}#context-aware-template-filter
[3]: https://github.com/gollum/gollum/pull/1818?utm_source={{ site.utm_source }}
[4]: https://dayoneapp.com?utm_source={{ site.utm_source }}
[5]: https://notational.net?utm_source={{ site.utm_source }}
[6]: https://brettterpstra.com/projects/nvalt/?utm_source={{ site.utm_source }}
