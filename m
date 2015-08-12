Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:32981 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbbHLNyQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Aug 2015 09:54:16 -0400
Received: by wijp15 with SMTP id p15so218851283wij.0
        for <linux-wpan@vger.kernel.org>; Wed, 12 Aug 2015 06:54:15 -0700 (PDT)
Date: Wed, 12 Aug 2015 15:54:09 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC 15/16] ieee802154: 6lowpan: check on valid 802.15.4 frame
Message-ID: <20150812135348.GA27586@omega>
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-16-git-send-email-alex.aring@gmail.com>
 <55CB4C24.1050707@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55CB4C24.1050707@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Wed, Aug 12, 2015 at 03:37:40PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 03/08/15 08:23, Alexander Aring wrote:
> >This patch adds frame control checks to check if the received frame is
> >something which could contain a 6LoWPAN packet.
> >
> >Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> >---
> >  include/linux/ieee802154.h  | 48 ++++++++++++++++++++++++++++++++++++++++++++-
> >  net/ieee802154/6lowpan/rx.c |  9 +++++++++
> >  2 files changed, 56 insertions(+), 1 deletion(-)
> >
> >diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
> >index 4f26c01..5a64fc0 100644
> >--- a/include/linux/ieee802154.h
> >+++ b/include/linux/ieee802154.h
> >@@ -208,7 +208,24 @@ enum {
> >  };
> >  /* frame control handling */
> >-#define IEEE802154_FCTL_ACKREQ	0x0020
> >+#define IEEE802154_FCTL_FTYPE		0x0003
> >+#define IEEE802154_FTYPE_DATA		0x0001
> >+#define IEEE802154_FCTL_ACKREQ		0x0020
> >+#define IEEE802154_FCTL_INTRA_PAN	0x0040
> >+#define IEEE802154_FCTL_DADDR		0x0c00
> >+#define IEEE802154_FCTL_DADDR_NONE	0x0000
> >+#define IEEE802154_FCTL_SADDR		0xc000
> >+#define IEEE802154_FCTL_SADDR_NONE	0x0000
> >+
> >+/*
> >+ * ieee802154_is_data - check if type is IEEE802154_FTYPE_DATA
> >+ * @fc: frame control bytes in little-endian byteorder
> >+ */
> >+static inline int ieee802154_is_data(__le16 fc)
> >+{
> >+	return (fc & cpu_to_le16(IEEE802154_FCTL_FTYPE)) ==
> >+		cpu_to_le16(IEEE802154_FTYPE_DATA);
> >+}
> >  /**
> >   * ieee802154_is_ackreq - check if acknowledgment request bit is set
> >@@ -220,6 +237,35 @@ static inline bool ieee802154_is_ackreq(__le16 fc)
> >  }
> >  /**
> >+ * ieee802154_is_intra_pan - check if intra pan id communication
> >+ * @fc: frame control bytes in little-endian byteorder
> >+ */
> >+static inline bool ieee802154_is_intra_pan(__le16 fc)
> >+{
> >+	return fc & cpu_to_le16(IEEE802154_FCTL_INTRA_PAN);
> >+}
> >+
> >+/**
> >+ * ieee802154_is_daddr_none - check if daddr mode is none
> >+ * @fc: frame control bytes in little-endian byteorder
> >+ */
> >+static inline bool ieee802154_is_daddr_none(__le16 fc)
> >+{
> >+	return (fc & cpu_to_le16(IEEE802154_FCTL_DADDR)) ==
> >+		cpu_to_le16(IEEE802154_FCTL_DADDR_NONE);
> >+}
> >+
> >+/**
> >+ * ieee802154_is_saddr_none - check if saddr mode is none
> >+ * @fc: frame control bytes in little-endian byteorder
> >+ */
> >+static inline bool ieee802154_is_saddr_none(__le16 fc)
> >+{
> >+	return (fc & cpu_to_le16(IEEE802154_FCTL_SADDR)) ==
> >+		cpu_to_le16(IEEE802154_FCTL_SADDR_NONE);
> >+}
> >+
> >+/**
> >   * ieee802154_get_fc_from_skb - get the frame control field from an skb
> >   * @skb: skb where the frame control field will be get from
> >   */
> >diff --git a/net/ieee802154/6lowpan/rx.c b/net/ieee802154/6lowpan/rx.c
> >index 48869ac..b1a9d14 100644
> >--- a/net/ieee802154/6lowpan/rx.c
> >+++ b/net/ieee802154/6lowpan/rx.c
> >@@ -264,6 +264,15 @@ static inline bool lowpan_is_reserved(u8 dispatch)
> >   */
> >  static bool lowpan_rx_h_check(struct sk_buff *skb)
> >  {
> >+	__le16 fc = ieee802154_get_fc_from_skb(skb);
> >+
> >+	/* check on ieee802154 conform 6LoWPAN header */
> >+	if (!ieee802154_is_data(fc) ||
> >+	    ieee802154_is_daddr_none(fc) ||
> >+	    ieee802154_is_saddr_none(fc) ||
> >+	    !ieee802154_is_intra_pan(fc))
> 
> Interesting, 6LoWPAN frames always have to have the intra PAN flag set? Did
> not know this until now.

I think intra-pan communication makes only sense, also I talked with
Phoebe about ~ 1 year ago where I asked myself how 802.15.4 6LoWPAN
handles non intra pan connection and I need to lookup again this in some
RFC. I think it was at [0].

"A destination PAN identifier is included in the frame, and it
 MUST match the PAN ID of the link in question."

which means "the destination pan id" must be the same of the current "link".
The "link" means -> what we currently set to the 802.15.4 MIB.

I think this answers the question "802.15.4 6LoWPAN is intra-pan only".


Another question is:

How to deal with 802.15.4 which have the same destination and source
PANID. The 802.15.4 says here it should set the intra panid bit.

NOW we could parse "source" and "destination" panid is the same and
intra panid is NOT set. But for me it's an invalid 802.15.4 frame and we
should drop it.

We currently don't drop this frames but we should do it in the lower
layer parsing which I will think about it how to deal frame parsing when
we have crypto working. :-/

Anyway I think everbody is welcome to send patches for this, but I maybe
want to change it later in some complete different parsing mechanism.

- Alex

[0] https://tools.ietf.org/html/rfc4944#section-3
