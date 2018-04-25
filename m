Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:55810 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752079AbeDYVUK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Apr 2018 17:20:10 -0400
Received: by mail-it0-f66.google.com with SMTP id 144-v6so7135197iti.5
        for <linux-wpan@vger.kernel.org>; Wed, 25 Apr 2018 14:20:09 -0700 (PDT)
Date: Wed, 25 Apr 2018 17:19:58 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH wpan] net: ieee802154: 6lowpan: fix frag reassembly
Message-ID: <20180425211957.35msxxypubh7yuka@x220t>
References: <20180420185413.8818-1-aring@mojatatu.com>
 <da1db914-bf92-ac44-9f60-5e5dfbc59b94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da1db914-bf92-ac44-9f60-5e5dfbc59b94@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi,

On Mon, Apr 23, 2018 at 05:11:39PM -0700, Eric Dumazet wrote:
> 
> 
> On 04/20/2018 11:54 AM, Alexander Aring wrote:
> > This patch initialize stack variables which are used in
> > frag_lowpan_compare_key to zero. In my case there are padding bytes in the
> > structures ieee802154_addr as well in frag_lowpan_compare_key. Otherwise
> > the key variable contains random bytes. The result is that a compare of
> > two keys by memcmp works incorrect.
> > 
> > Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
> > Signed-off-by: Alexander Aring <aring@mojatatu.com>
> > Reported-by: Stefan Schmidt <stefan@osg.samsung.com>
> > ---
> > So far I see it's a case of 32 alignment in frag_v4_compare_key and
> > frag_v6_compare_key and I am not sure about if this works on all arch
> > correctly.
> > 
> >  net/ieee802154/6lowpan/6lowpan_i.h  |  4 ++--
> >  net/ieee802154/6lowpan/reassembly.c | 14 +++++++-------
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
> > index b8d95cb71c25..44a7e16bf3b5 100644
> > --- a/net/ieee802154/6lowpan/6lowpan_i.h
> > +++ b/net/ieee802154/6lowpan/6lowpan_i.h
> > @@ -20,8 +20,8 @@ typedef unsigned __bitwise lowpan_rx_result;
> >  struct frag_lowpan_compare_key {
> >  	u16 tag;
> >  	u16 d_size;
> > -	const struct ieee802154_addr src;
> > -	const struct ieee802154_addr dst;
> > +	struct ieee802154_addr src;
> > +	struct ieee802154_addr dst;
> >  };
> >  
> >  /* Equivalent of ipv4 struct ipq
> > diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> > index 1790b65944b3..2cc224106b69 100644
> > --- a/net/ieee802154/6lowpan/reassembly.c
> > +++ b/net/ieee802154/6lowpan/reassembly.c
> > @@ -75,14 +75,14 @@ fq_find(struct net *net, const struct lowpan_802154_cb *cb,
> >  {
> >  	struct netns_ieee802154_lowpan *ieee802154_lowpan =
> >  		net_ieee802154_lowpan(net);
> > -	struct frag_lowpan_compare_key key = {
> > -		.tag = cb->d_tag,
> > -		.d_size = cb->d_size,
> > -		.src = *src,
> > -		.dst = *dst,
> > -	};
> > +	struct frag_lowpan_compare_key key = {};
> >  	struct inet_frag_queue *q;
> >  
> > +	key.tag = cb->d_tag;
> > +	key.d_size = cb->d_size;
> > +	key.src = *src;
> > +	key.dst = *dst;
> > +
> >  	q = inet_frag_find(&ieee802154_lowpan->frags, &key);
> >  	if (!q)
> >  		return NULL;
> > @@ -372,7 +372,7 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
> >  	struct lowpan_frag_queue *fq;
> >  	struct net *net = dev_net(skb->dev);
> >  	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
> > -	struct ieee802154_hdr hdr;
> > +	struct ieee802154_hdr hdr = {};
> >  	int err;
> >  
> >  	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)
> > 
> 
> Hi Alexander.
> 
> Thanks for working on this !
> 
> It looks like only the last chunk was really needed to fix this bug, right ?
> 

Yes, the last chunk is needed because:

 .src = *src,

but it will not fix everything, see below. The reason why I was not
sure is that I get packet drops with many fragments and _virtual_
hardware which doesn't should have any drops because I don't use
something to make drops.

> Compiler should really init everything, and not leave garbage bytes in :
> 
> 	struct frag_lowpan_compare_key key = {
> 		.tag = cb->d_tag,
> 		.d_size = cb->d_size,
> 		.src = *src,
> 		.dst = *dst,
> 	};

I talked privately with Stefan and we both use (but I have the same
issue with my host compiler 6.3.0 debian stretch):

gcc version 7.3.1

in my case I use a x86_64 qemu emulation.

my test is:

$ ping fe80::38c7:dc15:6089:4cc8%lowpan0 -s 1024 -c 10000 -i 0.025

which ends in about ~10 fragments (I don't remember the exact value, we
have ~80 bytes payload per frame only)

and I get back:

10000 packets transmitted, 6192 received, 38% packet loss, time 326431ms

ping implementation is:

ping utility, iputils-s20161105

I did the following changes:

---
@@ -590,8 +593,30 @@ static int lowpan_obj_cmpfn(struct rhashtable_compare_arg *arg, const void *ptr)
 {
        const struct frag_lowpan_compare_key *key = arg->key;
        const struct inet_frag_queue *fq = ptr;
+       const struct frag_lowpan_compare_key *key2 = (const struct frag_lowpan_compare_key *)&fq->key;
+       int rc, rc2;
+
+       rc2 = !!memcmp(&fq->key, key, sizeof(*key));
+
+       if (sizeof(*key) > sizeof(fq->key))
+               BUG();
+
+       rc = ((key2->tag == key->tag) &&
+             (key2->d_size == key->d_size) &&
+             ieee802154_addr_equal(&key2->src, &key->src) &&
+             ieee802154_addr_equal(&key2->dst, &key->dst));
+
+       if (rc) {
+               if (rc2 != 0) {
+                       pr_info("XXXXXXXXXXXXXXXXXXXX BINGO %d\n", rc2);
+                       print_hex_dump(KERN_INFO, "key data: ", DUMP_PREFIX_ADDRESS,
+                                      16, 1, key, sizeof(*key), true);
+                       print_hex_dump(KERN_INFO, "key2 data: ", DUMP_PREFIX_ADDRESS,
+                                      16, 1, key2, sizeof(*key2), true);
+               }
+       }
---

This change will check between memcmp() and fields compare and report a
BINGO inclusive hexdump() when they report different results which they
should not.

While debugging that I saw that fq->key is a union which doesn't has the
"frag_lowpan_compare_key" inside. Which is still fine because we are not
bigger than frag_v6_compare_key. I did some BUG() if this occurs.
Just as side note.

Please also note I _only_ get this code triggered when I am lucky and
the hashfn report the same hash for some mismatch keys (I saw this is
already the case and seems enough to debug).

I get this on my dmesg output:

---
6LoWPAN: XXXXXXXXXXXXXXXXXXXX BINGO 1
key data: 000000004c4f1290: 55 0b 30 04 ff ff ff ff 02 00 ef be 00 00 00 00  U.0.............
key data: 00000000f28c6d16: cd 0b 00 00 00 00 00 00 03 00 ef be 00 00 00 00  ................
key data: 00000000c3564bd8: c8 4c 89 60 15 dc c7 3a                          .L.`...:
key2 data: 000000000469f467: 55 0b 30 04 02 88 ff ff 02 00 ef be 00 00 00 00  U.0.............
key2 data: 00000000c3bc7aca: cd 0b 00 00 00 00 00 00 03 00 ef be 00 00 00 00  ................
key2 data: 00000000d2a3a530: c8 4c 89 60 15 dc c7 3a                          .L.`...:
---

pahole reports about frag_lowpan_compare_key the following (we should move
the padding "bits" to the end. Now I know how to deal with pahole):

---
struct frag_lowpan_compare_key {
    u16                        tag;                  /*     0     2 */
    u16                        d_size;               /*     2     2 */

    /* XXX 4 bytes hole, try to pack */

    struct ieee802154_addr     src;                  /*     8    16 */
    struct ieee802154_addr     dst;                  /*    24    16 */

    /* size: 40, cachelines: 1, members: 4 */
    /* sum members: 36, holes: 1, sum holes: 4 */
    /* last cacheline: 40 bytes */
};
---

As you can see starting at offset 4 size 4 I have a 4 bytes hole.
Compare to the hexdump: (I marked the bytes with ^^)

---
key data: 000000004c4f1290: 55 0b 30 04 ff ff ff ff 02 00 ef be 00 00 00 00  U.0.............
                                        ^^ ^^ ^^ ^^
key data: 00000000f28c6d16: cd 0b 00 00 00 00 00 00 03 00 ef be 00 00 00 00  ................
key data: 00000000c3564bd8: c8 4c 89 60 15 dc c7 3a                          .L.`...:
key2 data: 000000000469f467: 55 0b 30 04 02 88 ff ff 02 00 ef be 00 00 00 00  U.0.............
                                         ^^ ^^ ^^ ^^
key2 data: 00000000c3bc7aca: cd 0b 00 00 00 00 00 00 03 00 ef be 00 00 00 00  ................
key2 data: 00000000d2a3a530: c8 4c 89 60 15 dc c7 3a                          .L.`...:
---

So the padding bits are different. The compare via memcmp didn't
reported 0, but compare by fields it reports that it's equal. That's
when my BINGO hits.

I received a lot of BINGO messages, but remember I had only luck that
the hashfn reports the same hash for it which seems to confirm there is
something not working with the padding bits.

I added afterwards this:

---
+       print_hex_dump(KERN_INFO, "key data before inet_frag_find: ", DUMP_PREFIX_ADDRESS,
+                      16, 1, &key, sizeof(key), true);
---

right before calling inet_frag_find and check for the padding bits.
I did the same command again but with a -s 100, which should end in two fragments:

---
key data before inet_frag_find: 0000000056195e0f: 06 00 94 00 00 00 00 00 03 00 ef be 00 00 00 00  ................
                                                              ^^ ^^ ^^ ^^ 
key data before inet_frag_find: 00000000bc3eefd4: 57 bc 05 52 e9 ea 9b be 02 00 ef be 00 00 00 00  W..R............
key data before inet_frag_find: 00000000a1c4ed4e: cd 0b 00 00 00 00 00 00                          ........
key data before inet_frag_find: 0000000056195e0f: 06 00 94 00 02 88 ff ff 03 00 ef be 00 00 00 00  ................
                                                              ^^ ^^ ^^ ^^
key data before inet_frag_find: 00000000bc3eefd4: 57 bc 05 52 e9 ea 9b be 02 00 ef be 00 00 00 00  W..R............
key data before inet_frag_find: 00000000a1c4ed4e: cd 0b 00 00 00 00 00 00  
---

It seems at the first fragment the stack will be zero  and then for the
next fragment there are some random bits inside the padding bits.
Maybe this behavior is compiler related... above the first fragment
seems to have ff..ff inside the padding bits, that's so far what fq->key
tells me and so far I understood is the first fragment.
(I only suppose here that the fragments will arrive synchronized order).

Also I get nothing reassembled anymore and the random padding bits are for
all followed frags always the same. 02 88 ff ff, I think it doesn't
matter...

----------

Everything works fine when I init frag_lowpan_compare_key with zero by
doing = {} and assign the values afterwards.

Ping reports:

10000 packets transmitted, 10000 received, 0% packet loss, time 1108587ms

This is what I assume for virtual hardware... but I guess I am only lucky,
that gcc handles = {} as memset(&foo, 0, sizeof(..)) somehow.

That's all what I can tell right now...

What should I do now? I am ready to debug this more...

- Alex
