Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:37161 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565AbbIPPxf (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 16 Sep 2015 11:53:35 -0400
Subject: Re: [RFC bluetooth-next 0/4] GHC compression detection
References: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
 <20150913135141.GA12307@omega>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55F9907B.7090305@osg.samsung.com>
Date: Wed, 16 Sep 2015 17:53:31 +0200
MIME-Version: 1.0
In-Reply-To: <20150913135141.GA12307@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Hello.

On 13/09/15 15:51, Alexander Aring wrote:
> Hi,
>
> On Wed, Sep 09, 2015 at 05:26:29PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> This is a first stab at RFC7400. So far we only hook into the NHC framework to
>> detect the three registered GHC types (extension header, UDP and ICMPv6).
>> This is aligned with how we detect the NHC frames.
>>
> can we add a "nhc_..." prefix to all module names? Then we have
> something like what netfilter does with "nf_...".
>

You mean like nhc_ghc_udp.c? Fine with me.

>> TODO items:
>> o How to handle reserved and unassigned ranges in the HEADER TYPE?
> Maybe it's better to remove the current nhc_id evaluation. I did this
> stuff with rb-tree by knowning RFC6282 only, there was the one
> information given that "nhc id" is a variable length bitfield only. I
> don't know how the "logic" about assign these nhc id's is, if iana has one.
>
> What I see when I look at [0]. Maybe we could grab the same mechanism like
> evaluate 6lowpan dispatch values, by returning RX_CONTINUE if the nhc_id
> doesn't match. Determined by nhc_id length mask and id.
>
> The rb-tree mechanism is MAYBE faster, but this depends on amount of
> registered entries. I don't think there is ever so much many nhc ids
> that a rb-tree give "huge" benefits that we should use a rb-tree now, or
> it making thinks too much complex. :-/
>
> I just stumble over rb-tree's to search a right datastructure for
> matching variable length bitfields -> "strings". Now I am not sure if
> this was a good idea to do this in that way.
>
> These rbtree's are getting also a benefits only when the nhc_id is more
> than one byte long and this also doesn't exist right now. Also the first
> byte need to have one or more subtree's. Means e.g. the first byte need
> to indicate that another bytes follows.
>
> I suppose they will add some nhc_id byte like "1111 1111" which
> indicates one byte will follows. If this will be only one byte, e.g. the
> "1111 1111" then rbtree is surely the wrong datastructure... but maybe
> they will also add some "1111 1110" which also indicates anothers
> subtree of nhc_id's. I don't know it because there is no information
> about that. Maybe iana [0] will say that with "Unassigned, reserved for
> extensions" and it should stand somewhere in RFC6282, but I don't see
> that somewhere inside of RFC6282 which describes "1111 1111". :-/
>
> They describes something about a nhc class:
>
> "(i.e., k one-bits followed by one zero-bit identify the general class
> of NHC, followed by class-specific bit assignments)."
>
> Maybe they meant something that:
>
> "1111 1111" -> BAR nhc classes
> "1111 1110" -> FOO nhc classes
> ....        -> ... nhc classes
>
> Then a rbtree _maybe_ gives some benefit but I also think it doesn't
> matter then, because it's simple not a huge amount of entries there.

The use cases for the NHC ID I have seen so far have been simple. Easy 
enough to handle with ID and mask handling like we do the dispatch value 
handling.

On the other hand we have the rb-tree logic already in place and used. 
Hard to say what future RFC's in this domain might bring and if an 
rbtree can play out it benefits.

For reserved and unassigned range we could simple registering these 
values from the core.

Right now my gut feeling is that we should leave it as is until it 
really gives us trouble.

regards
Stefan Schmidt
