Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:32952 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbbEZNIm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 09:08:42 -0400
Received: by wgez8 with SMTP id z8so96703903wge.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 06:07:56 -0700 (PDT)
Date: Tue, 26 May 2015 10:58:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v2 bluetooth-next] ieee802154: add set transmit power
 support
Message-ID: <20150526085833.GB2747@omega>
References: <1432478793-17254-1-git-send-email-varkab@cdac.in>
 <5562B038.5080102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5562B038.5080102@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Mon, May 25, 2015 at 10:46:40AM +0530, Varka Bhadram wrote:
> Hi,
> 
> On 05/24/2015 08:16 PM, Varka Bhadram wrote:
> 
> >This patch adds transmission power setting support for IEEE-802.15.4
> >devices via nl802154.
> >
> >Signed-off-by: Varka Bhadram <varkab@cdac.in>
> >---
> >  include/net/cfg802154.h   |    1 +
> >  net/ieee802154/nl802154.c |   21 +++++++++++++++++++++
> >  net/ieee802154/rdev-ops.h |   12 ++++++++++++
> >  net/ieee802154/trace.h    |   15 +++++++++++++++
> >  net/mac802154/cfg.c       |   19 +++++++++++++++++++
> >  5 files changed, 68 insertions(+)
> >
> >diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> >index 4de59aa..2e3bb01 100644
> >--- a/include/net/cfg802154.h
> >+++ b/include/net/cfg802154.h
> >@@ -44,6 +44,7 @@ struct cfg802154_ops {
> >  	int	(*set_channel)(struct wpan_phy *wpan_phy, u8 page, u8 channel);
> >  	int	(*set_cca_mode)(struct wpan_phy *wpan_phy,
> >  				const struct wpan_phy_cca *cca);
> >+	int     (*set_tx_power)(struct wpan_phy *wpan_phy, s32 power);
> >  	int	(*set_pan_id)(struct wpan_phy *wpan_phy,
> >  			      struct wpan_dev *wpan_dev, __le16 pan_id);
> >  	int	(*set_short_addr)(struct wpan_phy *wpan_phy,
> >diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> >index 54f4959..42bc3d7 100644
> >--- a/net/ieee802154/nl802154.c
> >+++ b/net/ieee802154/nl802154.c
> >@@ -783,6 +783,19 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
> >  	return rdev_set_cca_mode(rdev, &cca);
> >  }
> >+static int nl802154_set_tx_power(struct sk_buff *skb, struct genl_info *info)
> >+{
> >+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
> >+	s32 power;
> >+
> >+	if (!info->attrs[NL802154_ATTR_TX_POWER])
> >+		return -EINVAL;
> >+
> >+	/* Collecting dBm value and converting to mBm*/
> >+	power = nla_get_s8(info->attrs[NL802154_ATTR_TX_POWER]) * 100;
> 
> I have noticed that wpan-tools converting the dBm value into mBm
> and sending over netlinks. In this case i should remove the conversion
> from dBm to mBm.
> 
> power = nla_get_s32(info->attrs[NL802154_ATTR_TX_POWER]);
> 
> I think above one is fine.
> 
> Do you think that conversion of dBm to mBm at userspace level is fine ..?

yes, "make it so".

- Alex
