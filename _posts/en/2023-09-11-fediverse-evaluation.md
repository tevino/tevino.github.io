---
layout: lab-post
title: Fediverse platform evaluation
lang: en
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
---

With Twitter becoming yet another TikTok and increasing control over content[^tb] [^shit], I started using the fediverse as an alternative. 

Now is a good time to join the fediverse as it has matured since I last tried. The fediverse user base is over 12M, thanks to Elon :)

[![Fediverse total users](/assets/2023-10_fediverse_users.png "Fediverse total users")][fedi_users]
[![Mastodon total and active users](/assets/2023-10_mastodon_users.png "Mastodon total and active users")][mas_users]


However, due to the decentralized nature of the fediverse, joining it is not as straightforward as joining Twitter. There are many platforms to choose from, analogous to email providers like Gmail.

This post describes my process for choosing a platform that works for me.

## Requirements

The fediverse currently works like email in terms of the relationship between users and platforms (providers).

If a platform goes down, your account disappears too. Account migration works via [redirections][single] and is impossible if the original platform shuts down.

Worst of all, content migration is unsupported on nearly all platforms except Calckey (details below). 

Let's face it - if Twitter can fail, so can fediverse servers[^small]. Self-hosting gives me full control of my data[^data1] [^data2] and removes one more [dependency][ti] out of my life.

I can self-host because of my tech background. For others, joining an instance/server is still better than staying on big platforms.

With many implementations to choose from, here are my requirements:

1. Content migration out (not in)
2. Multi-language post support so I and followers can subscribe to certain languages
3. Following people across platforms
4. Posting and editing
5. Searching my and followers' posts in unicode
6. Searching federated content by hashtag
7. Low resource usage for sustainability[^resource]

## Evaluation

### GoToSocial

Designed with single-person server in mind, no external services needed - perfect for my case. 

Worked great given the light resource usage.

Front-ends like [elk][elk] allows language selection during posting, but this [failed to propagate][gts_bug] across servers so Mastodon instances didn't recognize language preferences.

Slow development and long-standing bugs like the multi-language issue are concerning.

Promising but not production-ready for me.

### Pleroma

Like GoToSocial, designed with single-person usecase in mind, but much more mature and popular.
Light weight resource usage given the rich features provided. Official deployment guide is source-based and developer-faced.
I like the Gopher support.

I observed some posts missing from my followers' timelines on other instances, even if they visited my profile directly. The missing posts existed on my own timeline and were public, and there were visible posts both newer and older to the missing ones.

Multi-language posting support was implemented by contributors, but [rejected by the author][pleroma_mr] due to complexity concerns:

> I'm sorry, I should have said something earlier, but I don't think this is a sensible thing to merge. It's 2000 lines of new code that touches so many aspects of the codebase, for a feature that doesn't seem it like it would get much usage.
> 
> The code itself looks good, but I'd rather not have this in pleroma mainline because of complexity reasons.

Doesn't seem like it will be added anytime soon.

### Akko
A Pleroma fork with translation and rapid development.
However, single user scenarios are no longer a priority.

### Calckey/Firefish

Content migration attracted me to it.

I managed to import backups successfully from Mastodon and Pleroma (no support for others), post titles were dropped during import but mostly good.

Their flagship instance has experienced crashes and migration-related issues recently (from the announcement):

- a month ago: Server crashed and repaired
- a week ago: Some users' home timeline shows error due to migration


Feeling pretty experimental at the moment.


### Mastodon

This is the one that I decided to avoid at the first place due to its aggressive resource usage.

Apart from that, it meets all my requirements, has great multi-language support - posts could be marked with a language tag so the viewers could subscribe/filter by the tag thus viewing only the content in the language you speak.

## Decision

I ended up with Mastodon despite the resource usage, as it is the only one that has multi-language support for both posting and reading.
Also as the most supported fediverse plaform, it's most likely to get future content migration capabilities.

This is not optimal to me, so I'm open to trying any implementations that has decent multi-language support in the future.



[^shit]: [An Audacious Plan to Halt the Internet's Enshittification - Cory Doctorow](https://www.youtube.com/watch?v=q118B_QdP2k)
[^tb]: Twitter demotes content they don't like, for example when mentioning competitors like Mastodon.
[^data1]: This is a general preference of myself and here's [a post]({% post_url en/2023-07-25-data %}) about it.
[^data2]: Links in my old tweets broke when I need them, see [this](https://www.theverge.com/2023/8/20/23838823/twitter-x-deleted-pictures-links-2014-metadata-t-co-shortener) about it.
[^small]: Another perspective is that the fediverse servers are smaller so the chance of being acquired and getting overloaded is also smaller, but I like to be prepared.
[^lang]: I post in English and Chinese, a workaround is separate accounts per language but took too much effort from my experience.
[^resource]: Can run on a $5 VPS.


[single]: https://jvns.ca/blog/2023/08/11/some-notes-on-mastodon/
[pleroma_mr]: https://git.pleroma.social/pleroma/pleroma/-/merge_requests/3822
[gts_bug]: https://github.com/superseriousbusiness/gotosocial/issues/1277
[ti]: https://sive.rs/ti#why
[elk]: https://elk.zone
[fedi_users]: https://fediverse.observer/stats
[mas_users]: https://mastodon-analytics.com