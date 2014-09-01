Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43863 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbaIALio (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Sep 2014 07:38:44 -0400
Date: Mon, 1 Sep 2014 13:38:37 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan status
Message-ID: <20140901113835.GA21564@omega>
References: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1409567774.3120.57.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Mon, Sep 01, 2014 at 01:36:14PM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> I saw your RFC mail (9 Aug) about generic compression layer. Was there
> any functionality changes by this RFC or was it just refactoring the
> code?
> 

It's not just refactoring. The point is that there are many of RFC's
outside which declare a next header compession format (like UDP). UDP is
the only one next header compression which we currenlty support. If we
don't add a layer to add a new header compression format, all people
hack this into the iphc.c file. I don't know what you think about this
but I really don't like that.

This code adds a layer for this and supports all other known next header
compression formats in the way that we drop the packets afterwards
instead of deliver garabage to next layer (IPv6).

The layer avoids that everybody hacks static code into iphc file.

Please let me know if this is okay for you, then I will send a v2 with
changes.

> Anyway, looks ok to me although I just browsed quickly through the code,
> did not really review it :) Just wondering do we need more
> subdirectories under 6lowpan or could we just put everything into
> 6lowpan dir (just to keep it simple)? No big preference here thou.
> 

Don't know, but there is a unkown number of possible next header compression
formats outside, we should split it in a new subdirectorie. What I
actually mean, don't hack every next header compression format in a
single file.

For address compression/uncompression this is fine, there is no unknown
numbers of compression ways.

I know only IPHC and HC1. HC1 should be support for receiving side and
it's obsolete, but this is rfc 4944 so it's only related to 802.15.4.

Some or later we need to add support for this, but this should not used
by bluetooth 6LoWPAN.

> I saw the mail from Varka Bhadram (6 Aug) about RFC 6775 support. That
> looked interesting. Did you get the code from him (if yes, could you
> also send it to me)? Do you know why this guy have not send this stuff
> to upstream?
> 

The 802.15.4 mac layer has some neighbor discovery issues which are not
solved currently. It's about two kinds of mac addresses, for bluetooth
it should be fine. A small description about this problem is here [1].

We need some way to trigger 6LoWPAN/Layer 2 data across the IPv6 layer
and this isn't easy. Everything what we do on runtime decisions makes
the IPv6 stack slower and we should avoid that.



I currently working on a big rework of the 802.15.4 layer and will try
to bring this mainline at end of this month. Our mac layer is currenlty
in an not useable state. :(

I don't have time to make some effort after IPv6, currently I work on
the rework and will solve the two kind mac addresses issues with the
neighbor discovery cache, then we are in some state which we don't have
some broken support of functionality.


Maybe simple talk with Varka about what he did there, because I don't
really know what he exactly did there. The code what I saw isn't
mainline able. [0] What I know that RFC 6775 and the actually
implementation need to handle the two kinds of mac addresses (which is
broken currenlty) and need support of context based address compression.

I don't have time to add support for this. I need to rescue the 802.15.4
layer. Sorry! Maybe after that... or maybe somebody will do this work.
It sounds for me crazy to support RFC6775 which has dependencies on
other functionality which we doesn't support right now. For bluetooth
the mac layer works great, we only needs support for context based
address compression then.


I CC the new mailinglist for IEEE 802.15.4/IEEE 802.15.4 6LoWPAN
"linux-wpan" and bluetooth. We should not talk about this under the
hood.

- Alex

[0] https://www.mail-archive.com/linux-zigbee-devel%40lists.sourceforge.net/msg02018.html
[1] http://www.spinics.net/lists/netdev/msg291767.html
