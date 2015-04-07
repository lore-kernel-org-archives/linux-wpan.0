Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35687 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753930AbbDGNZG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Apr 2015 09:25:06 -0400
Received: by widdi4 with SMTP id di4so17319247wid.0
        for <linux-wpan@vger.kernel.org>; Tue, 07 Apr 2015 06:25:05 -0700 (PDT)
Date: Tue, 7 Apr 2015 15:25:02 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv3 bluetooth-next 2/4] nl802154: add set interface cmd
Message-ID: <20150407132459.GD16415@omega>
References: <1428407393-16005-1-git-send-email-alex.aring@gmail.com>
 <1428407393-16005-3-git-send-email-alex.aring@gmail.com>
 <20150407135902.2b885270@zoidberg>
 <20150407122149.GA16415@omega>
 <20150407142930.662c0f92@zoidberg>
 <20150407125949.GB16415@omega>
 <20150407150232.75e3df70@zoidberg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150407150232.75e3df70@zoidberg>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

On Tue, Apr 07, 2015 at 03:02:32PM +0200, Phoebe Buckheister wrote:
> On Tue, 7 Apr 2015 14:59:52 +0200
> Alexander Aring <alex.aring@gmail.com> wrote:
> 
> > On Tue, Apr 07, 2015 at 02:29:30PM +0200, Phoebe Buckheister wrote:
> > > On Tue, 7 Apr 2015 14:21:52 +0200
> > > Alexander Aring <alex.aring@gmail.com> wrote:
> > > 
> > > > Hi Phoebe,
> > > > 
> > > > On Tue, Apr 07, 2015 at 01:59:02PM +0200, Phoebe Buckheister
> > > > wrote:
> > > > > On Tue,  7 Apr 2015 13:49:51 +0200
> > > > > Alexander Aring <alex.aring@gmail.com> wrote:
> > > > > 
> > > > > > This patch introduce the NL802154_CMD_SET_INTERFACE command
> > > > > > which handles setting of all wpan interface mac attributes.
> > > > > > his will introduce an easilier wpan mac settings handling in
> > > > > > userspace application with nl802154.
> > > > > > 
> > > > > > Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> > > > > > ---
> > > > > >  net/ieee802154/nl802154.c | 110
> > > > > > ++++++++++++++++++++++++++++++++++++++++++++++ 1 file
> > > > > > changed, 110 insertions(+)
> > > > > > 
> > > > > > diff --git a/net/ieee802154/nl802154.c
> > > > > > b/net/ieee802154/nl802154.c index c12c07f..e2f50ba 100644
> > > > > > --- a/net/ieee802154/nl802154.c
> > > > > > +++ b/net/ieee802154/nl802154.c
> > > > > > @@ -603,6 +603,108 @@ static int nl802154_get_interface(struct
> > > > > > sk_buff *skb, struct genl_info *info) return
> > > > > > genlmsg_reply(msg, info); }
> > > > > >  
> > > > > > +static int nl802154_set_interface(struct sk_buff *skb, struct
> > > > > > genl_info *info) +{
> > > > > > +	struct cfg802154_registered_device *rdev =
> > > > > > info->user_ptr[0];
> > > > > > +	struct net_device *dev = info->user_ptr[1];
> > > > > > +	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (info->attrs[NL802154_ATTR_PAN_ID]) {
> > > > > > +		__le16 pan_id;
> > > > > > +
> > > > > > +		if (wpan_dev->iftype ==
> > > > > > NL802154_IFTYPE_MONITOR)
> > > > > > +			return -EINVAL;
> > > > > > +
> > > > > > +		if (netif_running(dev))
> > > > > > +			return -EBUSY;
> > > > > > +
> > > > > > +		pan_id =
> > > > > > nla_get_le16(info->attrs[NL802154_ATTR_PAN_ID]);
> > > > > > +		ret = rdev_set_pan_id(rdev, wpan_dev,
> > > > > > pan_id);
> > > > > > +		if (ret < 0)
> > > > > > +			return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (info->attrs[NL802154_ATTR_SHORT_ADDR]) {
> > > > > > +		__le16 short_addr;
> > > > > > +
> > > > > > +		if (wpan_dev->iftype ==
> > > > > > NL802154_IFTYPE_MONITOR)
> > > > > > +			return -EINVAL;
> > > > > 
> > > > > This is not good. You may have partially applied the requested
> > > > > settings when you return with an error, leaving the device in
> > > > > some intermediate state that is most likely not useful. It'd be
> > > > > better to first check whether all settings can be applied, and
> > > > > then apply them all at once. But even then we have a problem
> > > > > with rolling back some changes if a command fails :/
> > > > >
> > > > 
> > > > Yes, we need kind of rollback here if the command failed. I also
> > > > stumble over this issue. [0] Mhh, we don't have it when I do each
> > > > command in their own CMD SET call. So then I will leave the
> > > > current behaviour as it is.
> > > > 
> > > > Some idea:
> > > > 
> > > > Solution would be on MAC settings that we really check if
> > > > everything is valid. Then we can set everything in the pib
> > > > values, after an interface up this values will be "really" set,
> > > > like address filter settings in phy registers.
> > > > 
> > > > This works for interface settings (MAC PIB values). But for phy
> > > > values this is more difficult, because it's directly driver-layer
> > > > calls. So we can't predigt if an driver layer return some error
> > > > then.
> > > 
> > > That sounds good. We could add another driver function that checks a
> > > PIB/MIB and returns "valid" or "i'm sorry, dave", where "valid" may
> > > only happen when the driver *knows* that it can load the *IB into
> > > the hardware. Any possible hardware errors are excluded by these
> > > checks,
> > 
> > I think we need such functionality anyway, I wrote in my previous mail
> > that the not _all_ valid 802.15.4 mac pib values are supported by real
> > transceivers. Like the mrf24j40 [0] which can set the MIN_BE value
> > only (I suppose MAX_BE is always 802.15.4 default). But nl802154
> > checks only on 802.15.4 constraints only, so you can set everything
> > which is allowed by 802.15.4. On a "doing interface up" it will fail
> > because the driver layer will told -EINVAL; then and you don't know
> > why (okay, experts knows why).
> > 
> > We need to check this value on the SoftMAC layer in
> > "net/mac802154/cfg.c".
> > 
> > Now the design question is "a function" or "a array like
> > channels_supported which extends the phy pib by us". I would prefer
> > the array solution and put simple a u32 backoff_exponents_supported in
> > phy_pib [1] and checking over flags if the transceiver supports it's
> > or not.
> > 
> > Then we can add more supported arrays for csma retries, frame retries,
> > tx_pwr (also design question if all bands or current band only),
> > etc...
> > 
> > (For lbt mode, we don't need such functionality... it's only a bool
> > and the HW flag is enough).
> > 
> > Currently we don't have this kind of problem, because most settings
> > can set on an at86rf230 transceiver only which is fully (and beyond)
> > 802.15.4 complaint.
> > 
> > Now the question is again:
> > 
> > It's okay to extend the "supported arrays" in phy pib or we should
> > introduce a driver_ops function? I prefer the array solution, because
> > we have already such thing which is described by 802.15.4 pib.
> 
> Either is fine. The values permitted by the standard are mostly
> bitmasks and min/max-pairs, so that actually makes more sense than a

So we could some union type for it like:

union wpan_phy_support {
	u32	mask;
	union {
		u16	min:16;
		u16	max:16;
	};
};

Don't know if this is good idea.

> check() function in each driver (until some driver doesn't fit that
> model, but we should worry about that then).
> 

ack.

- Alex
