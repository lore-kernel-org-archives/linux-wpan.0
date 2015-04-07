Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33162 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbbDGMV7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 08:21:59 -0400
Received: by wgin8 with SMTP id n8so54096477wgi.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 05:21:58 -0700 (PDT)
Date: Tue, 7 Apr 2015 14:21:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 2/4] nl802154: add set interface cmd
Message-ID: <20150407122149.GA16415@omega>
References: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
 <1428407393-16005-3-git-send-email-alex.aring@gmail.com>
 <20150407135902.2b885270@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150407135902.2b885270@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Phoebe,

On Tue, Apr 07, 2015 at 01:59:02PM +0200, Phoebe Buckheister wrote:
> On Tue,  7 Apr 2015 13:49:51 +0200
> Alexander Aring <alex.aring@gmail.com> wrote:
> 
> > This patch introduce the NL802154_CMD_SET_INTERFACE command which
> > handles setting of all wpan interface mac attributes. his will
> > introduce an easilier wpan mac settings handling in userspace
> > application with nl802154.
> > 
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > ---
> >  net/ieee802154/nl802154.c | 110
> > ++++++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 110
> > insertions(+)
> > 
> > diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> > index c12c07f..e2f50ba 100644
> > --- a/net/ieee802154/nl802154.c
> > +++ b/net/ieee802154/nl802154.c
> > @@ -603,6 +603,108 @@ static int nl802154_get_interface(struct
> > sk_buff *skb, struct genl_info *info) return genlmsg_reply(msg, info);
> >  }
> >  
> > +static int nl802154_set_interface(struct sk_buff *skb, struct
> > genl_info *info) +{
> > +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
> > +	struct net_device *dev = info->user_ptr[1];
> > +	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
> > +	int ret;
> > +
> > +	if (info->attrs[NL802154_ATTR_PAN_ID]) {
> > +		__le16 pan_id;
> > +
> > +		if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> > +			return -EINVAL;
> > +
> > +		if (netif_running(dev))
> > +			return -EBUSY;
> > +
> > +		pan_id =
> > nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
> > +		ret = rdev_set_pan_id(rdev, wpan_dev, pan_id);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	if (info->attrs[NL802154_ATTR_SHORT_ADDR]) {
> > +		__le16 short_addr;
> > +
> > +		if (wpan_dev->iftype == NL802154_IFTYPE_MONITOR)
> > +			return -EINVAL;
> 
> This is not good. You may have partially applied the requested settings
> when you return with an error, leaving the device in some intermediate
> state that is most likely not useful. It'd be better to first check
> whether all settings can be applied, and then apply them all at once.
> But even then we have a problem with rolling back some changes if a
> command fails :/
>

Yes, we need kind of rollback here if the command failed. I also stumble
over this issue. [0] Mhh, we don't have it when I do each command in their
own CMD SET call. So then I will leave the current behaviour as it is.

Some idea:

Solution would be on MAC settings that we really check if everything is
valid. Then we can set everything in the pib values, after an interface
up this values will be "really" set, like address filter settings in phy
registers.

This works for interface settings (MAC PIB values). But for phy values
this is more difficult, because it's directly driver-layer calls. So we
can't predigt if an driver layer return some error then.


If nobody complaint then I will send a v4 and remove the nl802154
settings, or maybe somebody has a better idea.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01568.html
