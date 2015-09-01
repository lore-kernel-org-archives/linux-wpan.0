Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38714 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbbIAHnl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 1 Sep 2015 03:43:41 -0400
Received: by wiclp12 with SMTP id lp12so20729513wic.1
        for <linux-wpan@vger.kernel.org>; Tue, 01 Sep 2015 00:43:39 -0700 (PDT)
Date: Tue, 1 Sep 2015 09:43:37 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFCv2 bluetooth-next 10/16] ieee820154: 6lowpan: dispatch
 evaluation rework
Message-ID: <20150901074336.GC1454@omega>
References: <1440089265-23366-1-git-send-email-alex.aring@gmail.com>
 <1440089265-23366-11-git-send-email-alex.aring@gmail.com>
 <55E41E4D.60508@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55E41E4D.60508@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Mon, Aug 31, 2015 at 11:28:45AM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 20/08/15 18:47, Alexander Aring wrote:
> >This patch complete reworks the evaluation of 6lowpan dispatch value by
> >introducing a receive handler mechanism for each dispatch value.
> >
> >A list of changes:
> >
> >  - Doing uncompression on-the-fly when FRAG1 is received, this require
> >    some special handling for 802.15.4 lltype in generic 6lowpan branch
> >    for setting the payload length correct.
> >  - Fix dispatch mask for fragmentation.
> >  - Add IPv6 dispatch evaluation for FRAG1.
> >  - Add skb_unshare for dispatch which might manipulate the skb data
> >    buffer.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  include/net/6lowpan.h               |  31 ++++--
> 
> Not sure if you might want to include Jukka here for the shared header part
> with BT.

Yes, I will do that when sending PATCH. Maybe I should also split this
patch, but I think it's fine. Very small changes.

> >  net/6lowpan/iphc.c                  |  13 ++-
> >  net/6lowpan/nhc_udp.c               |  13 ++-
> >  net/ieee802154/6lowpan/6lowpan_i.h  |  12 +++
> >  net/ieee802154/6lowpan/reassembly.c | 126 +++++++++++++++++-------
> >  net/ieee802154/6lowpan/rx.c         | 188 ++++++++++++++++++++++++------------
> >  6 files changed, 278 insertions(+), 105 deletions(-)
> >
> >diff --git a/include/net/6lowpan.h b/include/net/6lowpan.h
> >index a2f59ec..3509841 100644
> >--- a/include/net/6lowpan.h
> >+++ b/include/net/6lowpan.h
> >@@ -126,13 +126,19 @@
> >  	 (((a)[6]) == 0xFF) &&	\
> >  	 (((a)[7]) == 0xFF))
> >-#define LOWPAN_DISPATCH_IPV6	0x41 /* 01000001 = 65 */
> >-#define LOWPAN_DISPATCH_HC1	0x42 /* 01000010 = 66 */
> >-#define LOWPAN_DISPATCH_IPHC	0x60 /* 011xxxxx = ... */
> >-#define LOWPAN_DISPATCH_FRAG1	0xc0 /* 11000xxx */
> >-#define LOWPAN_DISPATCH_FRAGN	0xe0 /* 11100xxx */
> >+#define LOWPAN_DISPATCH_IPV6		0x41 /* 01000001 = 65 */
> >+#define LOWPAN_DISPATCH_IPHC		0x60 /* 011xxxxx = ... */
> >+#define LOWPAN_DISPATCH_IPHC_MASK	0xe0
> >-#define LOWPAN_DISPATCH_MASK	0xf8 /* 11111000 */
> >+static inline bool lowpan_is_ipv6(u8 dispatch)
> >+{
> >+	return dispatch == LOWPAN_DISPATCH_IPV6;
> >+}
> >+
> >+static inline bool lowpan_is_iphc(u8 dispatch)
> >+{
> >+	return (dispatch & LOWPAN_DISPATCH_IPHC_MASK) == LOWPAN_DISPATCH_IPHC;
> >+}
> >  #define LOWPAN_FRAG_TIMEOUT	(HZ * 60)	/* time-out 60 sec */
> >@@ -218,6 +224,19 @@ struct lowpan_priv *lowpan_priv(const struct net_device *dev)
> >  	return netdev_priv(dev);
> >  }
> >+struct lowpan_802154_cb {
> >+	u16 d_tag;
> >+	unsigned int d_size;
> >+	u8 d_offset;
> >+};
> >+
> >+static inline
> >+struct lowpan_802154_cb *lowpan_802154_cb(const struct sk_buff *skb)
> >+{
> >+	BUILD_BUG_ON(sizeof(struct lowpan_802154_cb) > sizeof(skb->cb));
> >+	return (struct lowpan_802154_cb *)skb->cb;
> >+}
> >+
> >  #ifdef DEBUG
> >  /* print data in line */
> >  static inline void raw_dump_inline(const char *caller, char *msg,
> >diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> >index 1e0071f..78c8a49 100644
> >--- a/net/6lowpan/iphc.c
> >+++ b/net/6lowpan/iphc.c
> >@@ -366,7 +366,18 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
> >  			return err;
> >  	}
> >-	hdr.payload_len = htons(skb->len);
> >+	switch (lowpan_priv(dev)->lltype) {
> >+	case LOWPAN_LLTYPE_IEEE802154:
> >+		if (lowpan_802154_cb(skb)->d_size)
> >+			hdr.payload_len = htons(lowpan_802154_cb(skb)->d_size -
> >+						sizeof(struct ipv6hdr));
> >+		else
> >+			hdr.payload_len = htons(skb->len);
> >+		break;
> >+	default:
> >+		hdr.payload_len = htons(skb->len);
> 
> The default and else block being the same here I think that can be
> simplified.
> >+		break;
> >+	}
> >  	pr_debug("skb headroom size = %d, data length = %d\n",
> >  		 skb_headroom(skb), skb->len);
> >diff --git a/net/6lowpan/nhc_udp.c b/net/6lowpan/nhc_udp.c
> >index c6bcaeb..72d0b57 100644
> >--- a/net/6lowpan/nhc_udp.c
> >+++ b/net/6lowpan/nhc_udp.c
> >@@ -71,7 +71,18 @@ static int udp_uncompress(struct sk_buff *skb, size_t needed)
> >  	 * here, we obtain the hint from the remaining size of the
> >  	 * frame
> >  	 */
> >-	uh.len = htons(skb->len + sizeof(struct udphdr));
> >+	switch (lowpan_priv(skb->dev)->lltype) {
> >+	case LOWPAN_LLTYPE_IEEE802154:
> >+		if (lowpan_802154_cb(skb)->d_size)
> >+			uh.len = htons(lowpan_802154_cb(skb)->d_size -
> >+				       sizeof(struct ipv6hdr));
> >+		else
> >+			uh.len = htons(skb->len + sizeof(struct udphdr));
> >+		break;
> >+	default:
> >+		uh.len = htons(skb->len + sizeof(struct udphdr));
> >+		break;
> >+	}
> 
> Else branch and default case same again.

I see no optimiziation here, what we could do would be a set of "uh.len"
like default case and then overwrite it -> but this confuse other
programmers.

> >  	pr_debug("uncompressed UDP length: src = %d", ntohs(uh.len));
> >  	/* replace the compressed UDP head by the uncompressed UDP
> >diff --git a/net/ieee802154/6lowpan/6lowpan_i.h b/net/ieee802154/6lowpan/6lowpan_i.h
> >index 9aa7b62..b4e17a7 100644
> >--- a/net/ieee802154/6lowpan/6lowpan_i.h
> >+++ b/net/ieee802154/6lowpan/6lowpan_i.h
> >@@ -7,6 +7,15 @@
> >  #include <net/inet_frag.h>
> >  #include <net/6lowpan.h>
> >+typedef unsigned __bitwise__ lowpan_rx_result;
> >+#define RX_CONTINUE		((__force lowpan_rx_result) 0u)
> >+#define RX_DROP_UNUSABLE	((__force lowpan_rx_result) 1u)
> >+#define RX_DROP			((__force lowpan_rx_result) 2u)
> >+#define RX_QUEUED		((__force lowpan_rx_result) 3u)
> >+
> >+#define LOWPAN_DISPATCH_FRAG1           0xc0
> >+#define LOWPAN_DISPATCH_FRAGN           0xe0
> >+
> >  struct lowpan_create_arg {
> >  	u16 tag;
> >  	u16 d_size;
> >@@ -62,4 +71,7 @@ int lowpan_header_create(struct sk_buff *skb, struct net_device *dev,
> >  			 const void *_saddr, unsigned int len);
> >  netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev);
> >+int lowpan_iphc_decompress(struct sk_buff *skb);
> >+lowpan_rx_result lowpan_rx_h_ipv6(struct sk_buff *skb);
> >+
...
> >+}
> >+
> >+static int lowpan_get_cb(struct sk_buff *skb, u8 frag_type,
> >+			 struct lowpan_802154_cb *cb)
> >  {
> >  	bool fail;
> >  	u8 pattern = 0, low = 0;
> >@@ -334,15 +376,19 @@ static int lowpan_get_frag_info(struct sk_buff *skb, const u8 frag_type,
> >  	fail = lowpan_fetch_skb(skb, &pattern, 1);
> >  	fail |= lowpan_fetch_skb(skb, &low, 1);
> >-	frag_info->d_size = (pattern & 7) << 8 | low;
> >+	cb->d_size = (pattern & 7) << 8 | low;
> 
> Magic numbers. Yeah,. I know they have been there before.

ok. Will introduce some define above this function.

- Alex
