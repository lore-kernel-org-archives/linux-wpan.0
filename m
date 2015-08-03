Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36994 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbHCJoT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Aug 2015 05:44:19 -0400
Received: by wibud3 with SMTP id ud3so105956848wib.0
        for <linux-wpan@vger.kernel.org>; Mon, 03 Aug 2015 02:44:17 -0700 (PDT)
Date: Mon, 3 Aug 2015 11:44:39 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: iphc, rfc6553/6554 and 6lo ESC discussion
Message-ID: <20150803094428.GA6399@omega>
References: <1438346288-14546-1-git-send-email-alex.aring@gmail.com>
 <6541.1438389931@sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6541.1438389931@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Hi,

sorry, I saw this mail right now.

On Fri, Jul 31, 2015 at 08:45:31PM -0400, Michael Richardson wrote:
> 
> {trimmed CC list}
> 
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > check the LL type which can be currently BTLE or IEEE802154. This could
>     > be useful to make different handling in iphc compress/decompress and
>     > evaluating LL private data of skb control block "skb->cb".
> 
> Speaking of iphc compression,  the IETF 6lo WG is currently looking at ways
> to expand the available HC and NHC space.  This is mostly so that the ROLL WG
> (which I co-chair) can then define a way to compress the RH3 and RPI headers
> (and the IPIP header required to insert those).
> 
> It would be great to have more people writing code in this discussion.
> If you need more pointers to the discussion, or even if you want to have a
> G+/Jitsi/etc. meeting to understand the *why* of the discussion, let me know.
> 

I never did some discussion with the IETF people. Mainly I work at most
with rfc6282 and rfc4944 and I have no idea how people at IETF working.
For me, I would like to understand the "*why*", also there is some
acronyms here which I don't know. I know what you mean with "HC" and
"NHC" only.

For adding new compression methods in 6LoWPAN, if they will be used in
more than one 6LoWPAN linklayer which is supported then it's some
candidate for "net/6lowpan" branch. Read below.

>     >    The handling is currently for 802.15.4 is in generic 6lowpan code
>     > currently not quite. This should be handled by private data. At the
>     > moment btle use the same handling like for 802.15.4 extended
>     > address. Nevertheless is we can cleanup some handling then in generic
>     > iphc functionality.
> 
> Something to think about is there are networks which are not 15.4...
> Including NFC, DECT/ULE, BACnet, and G.9959 (which uses 8-bit
> short-addresses).
> 

That's fine, my intention with this patch is to make the 6lowpan generic
branch not specify to any linklayer. Currently that is not true because
we have some addr_type parameters at iphc compress/decompress functions.
These values comming from the 802.15.4 subsystem.

With a lltype we can introduce some switch case mechanism while iphc
function calling and evaluate _linklayer_ private data and in this
switch-case (like address compress/decompression) we can do different
things for each linklayer.

Also it is possible to access private data per (skb - the skb is the
network buffer which goes to each layer, this has some control block
array, which linklayer 6lowpan code can put data into it before calling
iphc functionality.)

looks like (don't to this real, I did not add some array size checks):

memcpy(my_link_layer_data, skb->cb, sizeof(*my_link_layer_data));

iphc_decompress(skb, skb->dev, .....);

inside of iphc_decompress we can do now:

switch (lowpan_priv(dev)->lltype)
case LOWPAN_LLTYPE_IEEE802154:
	my_link_layer_data_802154 = skb->cb;
	/* do complicated 802.15.4 short/extended handling */
	break;
case LOWPAN_LLTYPE_BTLE:
	my_link_layer_data_btle = skb->cb;
	/* do BTLE address handling */
	break;
case LOWPAN_LLTYPE_DECT:
	my_link_layer_data_dect = skb->cb;
	/* do BTLE address handling */
	break;
case LOWPAN_LLTYPE_FOOBAR:
	my_link_layer_data_foobar = skb->cb;
	/* do BTLE address handling */
	break;
....
}

so the goal is to get rid out the linklayer specific code out of
net/6lowpan.

The goal of "net/6lowpan" was to implement compression methods which are
described in two or more 6LoWPAN rfc's. This is actually iphc
compression which is described in BTLE/802.15.4.

When there comming more compression methods we need to figure out, if
it's only belong to one 6LoWPAN rfc, then it's not for "net/6lowpan".

With the lltype in 6lowpan we can do at some places different handling
in the compression methods of "net/6lowpan" at some places.

Additional we can in "IPv6" casting to lowpan_priv, which contains some
data from the "net/6lowpan" branch like IPHC CID table. But also
possible is to make some 6lowpan linklayer different handling inside of
IPv6.

> My gut is that DECT/ULE is going to take over :-)
> 

mhhh, ok. Good to know. :-/

I already know many people which hopes/thinks that 802.15.4 will die in
the next years. Is some good motivation for me. :-)

- Alex
