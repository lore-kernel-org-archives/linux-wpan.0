Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:42489 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbbACLCj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Jan 2015 06:02:39 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so5528428wes.16
        for <linux-wpan@vger.kernel.org>; Sat, 03 Jan 2015 03:02:37 -0800 (PST)
Date: Sat, 3 Jan 2015 12:02:32 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] af_ieee802154: make header uapi conform
Message-ID: <20150103110229.GA10722@omega>
References: <1420127077-25699-1-git-send-email-alex.aring@gmail.com>
 <715AC34D-9929-4959-A0E9-48B748F8E22F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <715AC34D-9929-4959-A0E9-48B748F8E22F@holtmann.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Marcel,

On Fri, Jan 02, 2015 at 05:02:57PM -0800, Marcel Holtmann wrote:
> Hi Alex,
> 
> > This patch uses __u16 and __u8 instead of u16 and u8 typedefs. These
> > typedefs coming from linux/types.h and are also easily available in
> > standard userspace environments. The af_ieee802154 header is normally
> > an userspace header. For now, we just copy this header in an userspace
> > application.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> > The "int addr_type" should be the above enum. I will fix this later. This
> > header has also other various issues. For now I just want the same version
> > in userspace which is also inside kernelspace.
> > 
> > include/net/af_ieee802154.h | 7 ++++---
> > 1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
> > index 7d38e2f..63af3f2 100644
> > --- a/include/net/af_ieee802154.h
> > +++ b/include/net/af_ieee802154.h
> > @@ -21,6 +21,7 @@
> > #define _AF_IEEE802154_H
> > 
> > #include <linux/socket.h> /* for sa_family_t */
> > +#include <linux/types.h>
> > 
> > enum {
> > 	IEEE802154_ADDR_NONE = 0x0,
> > @@ -34,10 +35,10 @@ enum {
> > 
> > struct ieee802154_addr_sa {
> > 	int addr_type;
> > -	u16 pan_id;
> > +	__u16 pan_id;
> > 	union {
> > -		u8 hwaddr[IEEE802154_ADDR_LEN];
> > -		u16 short_addr;
> > +		__u8 hwaddr[IEEE802154_ADDR_LEN];
> > +		__u16 short_addr;
> > 	};
> > };
> 
> which address information is this? Are these the socket addresses you use for bind(), connect() etc.
> 
> In that case shouldn't this be sa_family_t instead.
> 

I making some research related to this and I think there no good news.

First to your question:

The af_ieee802154.h contains an another struct, the "sockaddr_ieee802154":

struct sockaddr_ieee802154 {
        sa_family_t family; /* AF_IEEE802154 */
        struct ieee802154_addr_sa addr;
};

See [0]. I think that is what you mean.

This is struct is for bind(), connect(). I have a small userspace
application which based on the old userspace tools "izchat".



This struct will be a cast to "struct sockaddr":

struct sockaddr {
        sa_family_t     sa_family;      /* address family, AF_xxx       */
        char            sa_data[14];    /* 14 bytes of protocol address */
};

See [1].



This will imply that sizeof(struct sockaddr_ieee802154) MUST NOT above
the 14 bytes sa_data. (Which is for the protocol address information)

IMPORTANT NOTE: There is no BUILD_BUG_ON to check on this!


I calculate it on 32 bit machines it's:

int (4) + u16 (2) + hwaddr (8) = 14 bytes

Okay that fits, but on 64 bit machines:

int (8) + u16 (2) + hwaddr (8) = 18 bytes

Okay, I don't know if we have a bufferoverflow now here. Maybe the last
4 bytes are simply cutted and this socket interface simple doesn't work
on 64 bit machines in some cases. If we have a bufferoverflow we should
fix it in stable otherwise maybe just fixing that it works on 64 bit
machines.


I didn't work much with the socket interface, I want more 6LoWPAN
support, the socket interface for 802.15.4 is more for running closed
standards inside userspace to avoid license issues and I suppose the
socket interface code needs a complete rework.

Do you have some suggestion how to fix that? Maybe just make "int
addr_type" to u8? I am fine with that, simple forget the enum because we
have only few bytes for socket address data.

- Alex

[0] http://lxr.free-electrons.com/source/include/net/af_ieee802154.h#L52
[1] http://lxr.free-electrons.com/source/include/linux/socket.h#L29
