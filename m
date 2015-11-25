Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35635 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbKYSRW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Nov 2015 13:17:22 -0500
Date: Wed, 25 Nov 2015 19:17:17 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv2 bluetooth-next 2/3] ipv6: add ipv6_addr_prefix_cpy
Message-ID: <20151125181713.GC4652@omega>
References: <1447799594-6050-1-git-send-email-alex.aring@gmail.com>
 <1447799594-6050-3-git-send-email-alex.aring@gmail.com>
 <5655E50C.5090906@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5655E50C.5090906@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kernel@pengutronix.de, mcr@sandelman.ca, lukasz.duda@nordicsemi.no, martin.gergeleit@hs-rm.de, "David S . Miller" <davem@davemloft.net>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, James Morris <jmorris@namei.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Patrick McHardy <kaber@trash.net>

On Wed, Nov 25, 2015 at 05:42:52PM +0100, Stefan Schmidt wrote:
> Hello.
> 
> On 17/11/15 23:33, Alexander Aring wrote:
> >This patch adds a static inline function ipv6_addr_prefix_cpy which
> >copies a ipv6 address prefix(argument pfx) into the ipv6 address prefix.
> >The prefix len is given by plen as bits. This function mainly based on
> >ipv6_addr_prefix which copies one address prefix from address into a new
> >ipv6 address destination and zero all other address bits.
> >
> >The difference is that ipv6_addr_prefix_cpy don't get a prefix from an
> >ipv6 address, it sets a prefix to an ipv6 address with keeping other
> >address bits. The use case is for context based address compression
> >inside 6LoWPAN IPHC header which keeping ipv6 prefixes inside a context
> >table to lookup address-bits without sending them.
> >
> >Cc: David S. Miller<davem@davemloft.net>
> >Cc: Alexey Kuznetsov<kuznet@ms2.inr.ac.ru>
> >Cc: James Morris<jmorris@namei.org>
> >Cc: Hideaki YOSHIFUJI<yoshfuji@linux-ipv6.org>
> >Cc: Patrick McHardy<kaber@trash.net>
> >Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> >---
> >  include/net/ipv6.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> >diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> >index e1a10b0..9d38fc2 100644
> >--- a/include/net/ipv6.h
> >+++ b/include/net/ipv6.h
> >@@ -382,6 +382,21 @@ static inline void ipv6_addr_prefix(struct in6_addr *pfx,
> >  		pfx->s6_addr[o] = addr->s6_addr[o] & (0xff00 >> b);
> >  }
> >+static inline void ipv6_addr_prefix_cpy(struct in6_addr *addr,
> >+					const struct in6_addr *pfx,
> >+					int plen)
> >+{
> 
> Naming it ipv6_addr_prefix_cop, as Sergei suggested, would be easier to
> read.

ok.

> >+	/* caller must guarantee 0 <= plen <= 128 */
> >+	int o = plen >> 3,
> >+	    b = plen & 0x7;
> >+
> 
> Any reason you are not doing the memset here before memcpy like it is done
> in ipv6_addr_prefi()?

ipv6_addr_prefix is more a "getter" for a prefix from an address. The
destination address (which should be the result) will memset the whole
address before copy the prefix from address to it.

THe ipv6_addr_prefix_copy will set a prefix given by second parameter
pfx and set the prefix to the address (given by first parameter).

Maybe the ipv6_addr_prefix could call:

1. memset(pfx, sizeof...)
2. ipv6_addr_prefix_copy(pfx, addr, plen);

but ipv6_addr_prefix_copy need to care about other bits which are set at
destination address, if (plen/8 != 0). I don't want to touch
ipv6_addr_prefix function and slow-down some mechanism.

- Alex
