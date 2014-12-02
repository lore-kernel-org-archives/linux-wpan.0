Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64256 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbaLBKM5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Dec 2014 05:12:57 -0500
Date: Tue, 2 Dec 2014 11:12:50 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 0/2] 6lowpan: introduce nhc framework
Message-ID: <20141202101246.GA5908@omega>
References: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
 <1417437183.2703.45.camel@jrissane-mobl.ger.corp.intel.com>
 <20141201150132.GB996@omega>
 <1417512216.2703.63.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1417512216.2703.63.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <mtownsend1973@gmail.com>, Marcel Holtmann <marcel@holtmann.org>

On Tue, Dec 02, 2014 at 11:23:36AM +0200, Jukka Rissanen wrote:
...
> 
> I forgot to mention earlier that I think we need to support the case
> where some clients are using different compression method than the other
> (at the same time). What do you think?
> 
>

_Currently_ I would to do the following:


Sending side:

We have a mapping from nexthdr IPv6 field to the configurated (at the
moment the defaults compression methods) next header compression.

lowpan_compress -> nexthdr to nhc struct -> do nhc compression

This is a 1:1 mapping for nexthdr as UDP we have RFC6282 UDP.

_Maybe_ we can do some socket options settings in the future to have not
always a 1:1 mapping. Sending sockopts to 6LoWPAN layer seems to be
difficult, I don't know how much possible that is and the IPv6 agree
with that. Otherwise we need some great idea to make allow different
compression methods per socket. Currently a 1:1 seems to be okay.


Receiving side:

There we need to support everything what we can support. The next header
compression id is a variable length of bitstring (that's why there is a
complicated rbtree datastructure inside the nhc framework).

This number is unique to each compression methods. It's some kind of n:1
mapping e.g. (UDP RFC6282) to UDP and (UDP FOOBAR) to UDP.



So sending side _can_ be optionally and receiving _should_ be implemented.

I have a new series which makes both optionally. The reason is that we
can register the NHC ID and print a warning which NHC ID isn't
supported. So this beahviour is more "We know this NHC but we don't
support compression and uncompression". This will print a warning and
users have two options:

1. Implement the nhc.

2. Change network configuration to not do this nhc on other nodes.

- Alex
