Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33057 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbbHDRoD (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Aug 2015 13:44:03 -0400
Received: by wijp15 with SMTP id p15so16067734wij.0
        for <linux-wpan@vger.kernel.org>; Tue, 04 Aug 2015 10:44:01 -0700 (PDT)
Date: Tue, 4 Aug 2015 19:44:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv3 bluetooth-next 2/6] ieee802154: add helpers for frame
 control checks
Message-ID: <20150804174412.GA22216@omega>
References: <1438246542-17633-1-git-send-email-alex.aring@gmail.com>
 <1438246542-17633-3-git-send-email-alex.aring@gmail.com>
 <55C0E859.2010503@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55C0E859.2010503@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, Aug 04, 2015 at 06:29:13PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 30/07/15 10:55, Alexander Aring wrote:
> >This patch introduce two static inline functions. The first to get the
> >frame control field from an sk_buff. The second is for checking on the
> >acknowledgment request bit on the frame control field. Later we can
> >introduce more functions to check on the frame control fields.
> >
> >These will deprecate the current behaviour which requires a
> >host-byteorder conversion and manually bit handling.
> >
> >Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> >---
> 
> Some language suggestions inside.

ok.
> >  include/linux/ieee802154.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> >diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> >index 1dc1f4e..4f26c01 100644
> >--- a/include/linux/ieee802154.h
> >+++ b/include/linux/ieee802154.h
> >@@ -25,6 +25,8 @@
> >  #include <linux/types.h>
> >  #include <linux/random.h>
> >+#include <linux/skbuff.h>
> >+#include <linux/unaligned/memmove.h>
> >  #include <asm/byteorder.h>
> >  #define IEEE802154_MTU			127
> >@@ -205,6 +207,33 @@ enum {
> >  	IEEE802154_SCAN_IN_PROGRESS = 0xfc,
> >  };
> >+/* frame control handling */
> >+#define IEEE802154_FCTL_ACKREQ	0x0020
> >+
> >+/**
> >+ * ieee802154_is_ackreq - check if acknowledgment request bit is set
> >+ * @fc: frame control bytes in little-endian byteorder
> >+ */
> >+static inline bool ieee802154_is_ackreq(__le16 fc)
> >+{
> >+	return fc & cpu_to_le16(IEEE802154_FCTL_ACKREQ);
> >+}
> >+
> >+/**
> >+ * ieee802154_get_fc_from_skb - get the frame control field from an skb
> 
> ... from a skb

ok.
> >+ * @skb: skb where the frame control field will be get from
> Maybe:
> 
> skb which contains the frame control field
> 

ok.
> >+ */
> >+static inline __le16 ieee802154_get_fc_from_skb(const struct sk_buff *skb)
> >+{
> >+	/* return some invalid fc on failure */
> Maybe:
> 
> return on invalid fc
> 

ok.
> >+	if (unlikely(skb->mac_len < 2)) {
> >+		WARN_ON(1);
> >+		return cpu_to_le16(0);
> >+	}
> >+
> >+	return (__force __le16)__get_unaligned_memmove16(skb_mac_header(skb));
> 
> Just to make sure we don't run into problems like we did with the 6lowpan
> stack. __get_unaligned_memmove16 is not pulling the fc bytes out of the skb,
> right? The skb stays as it is.
> 

right it doesn't manipulate the skb. For the "problems like we did with
the 6lowpan" you need to decide which problems, I see several:

 - running skb_pull (which removes) buffer and we don't have the room to
   pull out the bytes of skb, example: skb->len = 3, skb_pull size is 4
   which ends in a BUG(), we need to check it with skb_may_pull before.

 - running skb_push and we don't have the headroom for that. Like
   headroom space is 3 but we running push for size 4. the function
   skb_cow will reallocte headroom if needed.

These two problems are mostly out of 6lowpan code (I think).

The problem which I mentioned at iphc is more different. This is read
out the data but we doesn't check if we getting a buffer out of read
access. Example:

tmp a[3], b[4];

memcpy(b, a, ARRAY_SIZE(b));

And the source pointer will read something from the stack. But this is
handled here by checking "unlikely(skb->mac_len < 2)".

> >+}
> >+
> >  /**
> >   * ieee802154_is_valid_psdu_len - check if psdu len is valid
> >   * available lengths:
> 
> Given the above is true you have my:
> 

ok.

- Alex
