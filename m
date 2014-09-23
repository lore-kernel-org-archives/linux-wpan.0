Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:40017 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbaIWJ1C (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Sep 2014 05:27:02 -0400
Received: by mail-wg0-f42.google.com with SMTP id a1so3969953wgh.25
        for <linux-wpan@vger.kernel.org>; Tue, 23 Sep 2014 02:27:01 -0700 (PDT)
Date: Tue, 23 Sep 2014 11:26:55 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan v4] ieee802154: 6lowpan: ensure header
 compression does not corrupt ipv6 header
Message-ID: <20140923092653.GA12857@omega>
References: <1411401123-7790-1-git-send-email-simon.vincent@xsilon.com>
 <20140922162148.GA7282@omega>
 <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1411463634.4860.65.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, marcel@holtmann.org

On Tue, Sep 23, 2014 at 12:13:54PM +0300, Jukka Rissanen wrote:
> Hi Alex,
> 
> On ma, 2014-09-22 at 18:21 +0200, Alexander Aring wrote:
> 
> > grml, I overlooked something the last version. But I will fix it while
> > >  
> > > -	cb->ackreq = !lowpan_is_addr_broadcast(daddr);
> > > +	/* TODO: Currently we only support extended_addr */
> > > +	info->daddr.mode = IEEE802154_ADDR_LONG;
> > 
> > now IEEE802154_ADDR_LONG is no little endian value copied from mac
> > header. Somewhere else converted the little endian value to an host understandable
> > enum/define number. For the rework I will remove this value. We should never
> > ever convert this value for parsing.
> > 
> > We use it only for af_802154 and userspace specification what addresses
> > should be used. But the above one to make this __le16 is incorrect. For
> > userspace we should create some enums for declaring different address
> > types. Then we can use this for 802.15.4 sockets.
> 
> BTW, at some point we might want to change the IEEE802154_ADDR_LONG in
> net/6lowpan/iphc.c to more generic. Now this IEEE 802154 specific enum
> needs to be mentioned in net/bluetooth/6lowpan.c which looks quite
> confusing.
> 

Yep, the generic name for such address is EUI-64. Forget the hyphen
there. There is alot of 802.15.4 specific 6lowpan defines in iphc.c.
They are defined in include/net/6lowpan.h, which should moved into an
internal header of "net/ieee802154/...".

And also we could do this maybe not as address type, more a address
length. EUI64 is 8 and the SHORT address is 2 bytes long. No special
handling about some address types, only handling about different lengt,
only handling about different lengths.

so we have some:

switch (address_length) {
case IEEE_EUI64_ADDRLEN:
case IEEE802154_SHORT_ADDRLEN:
default:
	/* not supported */
}

the second case is only for IEEE802154 handling, maybe we could also
check the netdev type, but that's not necessary. bluetooth should never
set IEEE802154_SHORT_ADDRLEN by calling lowpan_header_create.

Also we don't support the case IEEE802154_SHORT_ADDRLEN right now. :-)
That's currently dead code, it's a complicated issue to support that...
but in near future we will support it, otherwise our stack is in an
unusable state.

I mean IEEE_EUI64_ADDRLEN, is in 802154 the extended address. In
bluetooth you need to generate the EUI64 with filling ff:fe pattern.
Like behaviour in ethernet. And drop the special type handling.

Is this okay?

- Alex
