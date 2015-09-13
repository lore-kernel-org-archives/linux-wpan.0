Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35181 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbIMNvy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 13 Sep 2015 09:51:54 -0400
Received: by wicge5 with SMTP id ge5so111764159wic.0
        for <linux-wpan@vger.kernel.org>; Sun, 13 Sep 2015 06:51:53 -0700 (PDT)
Date: Sun, 13 Sep 2015 15:51:42 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 0/4] GHC compression detection
Message-ID: <20150913135141.GA12307@omega>
References: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1441812393-32472-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Hi,

On Wed, Sep 09, 2015 at 05:26:29PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> This is a first stab at RFC7400. So far we only hook into the NHC framework to
> detect the three registered GHC types (extension header, UDP and ICMPv6).
> This is aligned with how we detect the NHC frames.
> 

can we add a "nhc_..." prefix to all module names? Then we have
something like what netfilter does with "nf_...".

> TODO items:
> o How to handle reserved and unassigned ranges in the HEADER TYPE?

Maybe it's better to remove the current nhc_id evaluation. I did this
stuff with rb-tree by knowning RFC6282 only, there was the one
information given that "nhc id" is a variable length bitfield only. I
don't know how the "logic" about assign these nhc id's is, if iana has one.

What I see when I look at [0]. Maybe we could grab the same mechanism like
evaluate 6lowpan dispatch values, by returning RX_CONTINUE if the nhc_id
doesn't match. Determined by nhc_id length mask and id.

The rb-tree mechanism is MAYBE faster, but this depends on amount of
registered entries. I don't think there is ever so much many nhc ids
that a rb-tree give "huge" benefits that we should use a rb-tree now, or
it making thinks too much complex. :-/

I just stumble over rb-tree's to search a right datastructure for
matching variable length bitfields -> "strings". Now I am not sure if
this was a good idea to do this in that way.

These rbtree's are getting also a benefits only when the nhc_id is more
than one byte long and this also doesn't exist right now. Also the first
byte need to have one or more subtree's. Means e.g. the first byte need
to indicate that another bytes follows.

I suppose they will add some nhc_id byte like "1111 1111" which
indicates one byte will follows. If this will be only one byte, e.g. the
"1111 1111" then rbtree is surely the wrong datastructure... but maybe
they will also add some "1111 1110" which also indicates anothers
subtree of nhc_id's. I don't know it because there is no information
about that. Maybe iana [0] will say that with "Unassigned, reserved for
extensions" and it should stand somewhere in RFC6282, but I don't see
that somewhere inside of RFC6282 which describes "1111 1111". :-/

They describes something about a nhc class:

"(i.e., k one-bits followed by one zero-bit identify the general class
of NHC, followed by class-specific bit assignments)."

Maybe they meant something that:

"1111 1111" -> BAR nhc classes
"1111 1110" -> FOO nhc classes
....        -> ... nhc classes

Then a rbtree _maybe_ gives some benefit but I also think it doesn't
matter then, because it's simple not a huge amount of entries there.

- Alex

[0] https://www.iana.org/assignments/_6lowpan-parameters/_6lowpan-parameters.xhtml#lowpan_nhc
