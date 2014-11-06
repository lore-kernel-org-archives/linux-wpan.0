Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34152 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbaKFJjL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 04:39:11 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so569028lbv.26
        for <linux-wpan@vger.kernel.org>; Thu, 06 Nov 2014 01:39:09 -0800 (PST)
Date: Thu, 6 Nov 2014 11:03:14 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 11/18] ieee802154: add
 ieee802154_random_extended_addr
Message-ID: <20141106100312.GA1071@x61s.campuswlan.hs-rm.de>
References: <1415217089-24919-1-git-send-email-alex.aring@gmail.com>
 <1415217089-24919-12-git-send-email-alex.aring@gmail.com>
 <545AD4DD.9030101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <545AD4DD.9030101@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi,

On Thu, Nov 06, 2014 at 07:24:37AM +0530, Varka Bhadram wrote:
> Hi Alex,
> 
> I have few doubts on this patch.
> 

ok.

> On Thursday 06 November 2014 01:21 AM, Alexander Aring wrote:
> 
> >This patch adds a new function to generate a random IEEE 802.15.4
> >extended address.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  include/linux/ieee802154.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> >diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> >index a907fe5..d043449 100644
> >--- a/include/linux/ieee802154.h
> >+++ b/include/linux/ieee802154.h
> >@@ -24,6 +24,7 @@
> >  #define LINUX_IEEE802154_H
> >  #include <linux/types.h>
> >+#include <linux/random.h>
> >  #include <asm/byteorder.h>
> >  #define IEEE802154_MTU			127
> >@@ -215,4 +216,17 @@ static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
> >  		(addr != cpu_to_le64(0xffffffffffffffffULL)));
> >  }
> >+/**
> >+ * ieee802154_random_extended_addr - generates a random extended address
> >+ * @addr: extended addr pointer to place the random address
> >+ */
> >+static inline void ieee802154_random_extended_addr(__le64 *addr)
> 
> First of all why do we need this functionality. Extended address will be configured by the
> user by using iz ..?
> 

We need such function for the perm extended address. The extended
address is some unique number. It's an EUI-64 address this should be
unique and hardware companies can allocate OUI. The EUI-64 is some
combine OUI and device identifier. The perm address can be used that the
driver ask the transceiver for serial id or eeprom and set the unique
extended address. Also the IEEE 802.15.4-2011 standard describes the
default value for an extended address as "Implementation specific". The
perm address is now the "Implementation specific" behaviour.

The iz tool sets no perm address, it's just another address than the
perm address if you want that. This is also only an optional parameter
if this is zero the perm address will be used.

Also we have now a default registration for a wpan interface, this will
always use the perm address which is a random extended address now.

We need this function like a random ethernet address. If a transceiver
doesn't support some serial id or eeprom where we can generate an EUI-64
address, then we will generate a valid random extended address.

In case of short address the default value is 0xffff. Short address will
be assign from coordinators... but we are far away from that to support
such behaviour.

> >+{
> >+	get_random_bytes(addr, IEEE802154_EXTENDED_ADDR_LEN);
> >+
> 
> Here we are getting random bytes of 8.
> 

correct.

> >+	/* toggle some bit if we hit an invalid extended addr */
> >+	if (!ieee802154_is_valid_extended_addr(*addr))
> >+		((u8 *)addr)[IEEE802154_EXTENDED_ADDR_LEN - 1] ^= 0x01;
> 
> If those 8 bytes not a valid addr, then you are toggling last bit, Why..?
> 

EUI-64 values 0xff..ff and 0x00..00 are owned by IEEE [0]. The function
"ieee802154_is_valid_extended_addr" will return "false" when we hit such
address. Now we flip some bit to get out of an invalid IEEE address...

btw. the 0xff..ff will be used as mapping for short broadcast address
and 0x00..00 should be the default monitor interface address. (This
should be not be changed at runtime, I have patches for this but there
is alot of other things where I have patches for it).

[0] https://standards.ieee.org/develop/regauth/tut/eui64.pdf

- Alex
