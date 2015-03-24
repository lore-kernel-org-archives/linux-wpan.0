Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:33534 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbCXIoB (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 24 Mar 2015 04:44:01 -0400
Received: by weop45 with SMTP id p45so157485932weo.0
        for <linux-wpan@vger.kernel.org>; Tue, 24 Mar 2015 01:44:00 -0700 (PDT)
Date: Tue, 24 Mar 2015 09:43:54 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/4] nl802154: add set wpan phy cmd
Message-ID: <20150324084351.GA728@omega>
References: <1427125541-28708-1-git-send-email-alex.aring@gmail.com>
 <1427125541-28708-2-git-send-email-alex.aring@gmail.com>
 <5510DD02.5030902@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5510DD02.5030902@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Varka,

On Tue, Mar 24, 2015 at 09:11:54AM +0530, Varka Bhadram wrote:
> Hi Alex,
> 
> On 03/23/2015 09:15 PM, Alexander Aring wrote:
> 
> >This patch adds NL802154_CMD_SET_WPAN_PHY command to set all wpan phy
> >attributes instead of doing separate commands. This will improve
> >userspace application handling of nl802154.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  net/ieee802154/nl802154.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> >diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> >index a4daf91..c12c07f 100644
> >--- a/net/ieee802154/nl802154.c
> >+++ b/net/ieee802154/nl802154.c
> >@@ -437,6 +437,49 @@ static int nl802154_get_wpan_phy(struct sk_buff *skb, struct genl_info *info)
> >  	return genlmsg_reply(msg, info);
> >  }
> >+static int nl802154_set_wpan_phy(struct sk_buff *skb, struct genl_info *info)
> >+{
> >+	struct cfg802154_registered_device *rdev = info->user_ptr[0];
> >+	int ret;
> >+
> >+	if (info->attrs[NL802154_ATTR_PAGE] &&
> >+	    info->attrs[NL802154_ATTR_CHANNEL]) {
> >+		u8 channel, page;
> >+
> >+		page = nla_get_u8(info->attrs[NL802154_ATTR_PAGE]);
> >+		channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
> >+		if (page > IEEE802154_MAX_PAGE ||
> >+		    channel > IEEE802154_MAX_CHANNEL)
> >+			return -EINVAL;
> >+
> >+		ret = rdev_set_channel(rdev, page, channel);
> >+		if (ret < 0)
> >+			return ret;
> 
> Why dont we return directly rdev_set_channel..
> Is there any significance to the check on *ret*...?
> 

The current case here is to abort all wpan_phy attributes when one is
failing. If we do a directly call of rdev_set_channel here then the
function returns also on success.

> >+	}
> >+
> >+	if (info->attrs[NL802154_ATTR_CCA_MODE]) {
> >+		struct wpan_phy_cca cca;
> >+
> >+		cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
> >+		if (cca.mode < NL802154_CCA_ENERGY ||
> >+		    cca.mode > NL802154_CCA_ATTR_MAX)
> >+			return -EINVAL;
> >+
> >+		if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
> >+			if (!info->attrs[NL802154_ATTR_CCA_OPT])
> >+				return -EINVAL;
> >+
> >+			cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
> >+			if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
> >+				return -EINVAL;
> >+		}
> >+
> >+		return rdev_set_cca_mode(rdev, &cca);
> >+	}

This branch need also running on success. Then applications can set
multiple phy pib attributes at one CMD call.

That's why I told in my "advantage/disadvantage mail" on 100%
correctness we need to handle a "rollback" on previous failure. On the
other hand this doesn't matter because setting with only ONE attribute
will keep the old behaviour. If we have more "capabilities" flags for
asking the phy what it supports we can mostly avoid "-EINVAL,
-EOPNOTSUPP" errors, otherwise the user application makes something
wrong. To return on previous attr setting while failure it's for stop
doing other things in kernelspace if any error occurs. But the userspace
application knows then that the setting of all phy attributes are in a
"unknown" state and need to dump PIB values again if an error occurs.

Handling the rollback in kernelspace is also not really possible since
IO access can always fail, also on rollback handling.

- Alex
