Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36839 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935362AbbDIKOj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 06:14:39 -0400
Received: by wgsk9 with SMTP id k9so92425200wgs.3
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 03:14:37 -0700 (PDT)
Date: Thu, 9 Apr 2015 12:14:34 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 3/4] ieee802154: add several phy supported
 handling
Message-ID: <20150409101432.GD1261@omega>
References: <1428491912-14027-1-git-send-email-alex.aring@gmail.com>
 <1428491912-14027-4-git-send-email-alex.aring@gmail.com>
 <55261AB2.6050500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55261AB2.6050500@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>, kernel@pengutronix.de

On Thu, Apr 09, 2015 at 11:52:42AM +0530, Varka Bhadram wrote:
> On 04/08/2015 04:48 PM, Alexander Aring wrote:
> > This patch adds support for phy supported handling for all other already
> > existing handling 802.15.4 functionality. We assume now a fully 802.15.4
> > complaint transceiver at phy allocation. If a transceiver can support
> > 802.15.4 default values only, then the values should be overwirtten by
> > values the transceiver supports.
> >
> > Signed-off-by: Alexander Aring <alex.aring@gmail.com> <mailto:alex.aring@gmail.com>
> > Suggested-by: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de> <mailto:phoebe.buckheister@itwm.fraunhofer.de>
> > ---
> >  include/net/cfg802154.h   |  5 +++++
> >  net/ieee802154/nl802154.c | 31 +++++++++++++++++++++----------
> >  net/mac802154/main.c      | 10 ++++++++++
> >  3 files changed, 36 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> > index c4d42ad..c9d09b1 100644
> > --- a/include/net/cfg802154.h
> > +++ b/include/net/cfg802154.h
> > @@ -61,6 +61,11 @@ struct cfg802154_ops {
> >  
> >  struct wpan_phy_supported {
> >  	u32 channels[IEEE802154_MAX_PAGE + 1];
> > +	u8 cca_modes, cca_opts;
> > +	u8 min_minbe, max_minbe, min_maxbe, max_maxbe;
> > +	s8 min_frame_retries, max_frame_retries;
> > +	u8 min_csma_backoffs, max_csma_backoffs;
> > +	bool lbt;
> 
> Declare variables one after other in multiple lines... Not in single line. :-) 
> 

ok.

> >  };
> >  
> >  struct wpan_phy_cca {
> > diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> > index 4ea64ef..7e3b2cc 100644
> > --- a/net/ieee802154/nl802154.c
> > +++ b/net/ieee802154/nl802154.c
> > @@ -625,11 +625,8 @@ static int nl802154_set_channel(struct sk_buff *skb, struct genl_info *info)
> >  	channel = nla_get_u8(info->attrs[NL802154_ATTR_CHANNEL]);
> >  
> >  	/* check 802.15.4 constraints */
> > -	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL)
> > -		return -EINVAL;
> > -
> > -	/* check if phy support this setting */
> > -	if (!(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
> > +	if (page > IEEE802154_MAX_PAGE || channel > IEEE802154_MAX_CHANNEL ||
> > +	    !(rdev->wpan_phy.supported.channels[page] & BIT(channel)))
> >  		return -EINVAL;
> >  
> >  	return rdev_set_channel(rdev, page, channel);
> > @@ -645,7 +642,9 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
> >  
> >  	cca.mode = nla_get_u32(info->attrs[NL802154_ATTR_CCA_MODE]);
> >  	/* checking 802.15.4 constraints */
> > -	if (cca.mode < NL802154_CCA_ENERGY || cca.mode > NL802154_CCA_ATTR_MAX)
> > +	if (cca.mode < NL802154_CCA_ENERGY ||
> > +	    cca.mode > NL802154_CCA_ATTR_MAX ||
> > +	    !(rdev->wpan_phy.supported.cca_modes & BIT(cca.mode)))
> >  		return -EINVAL;
> >  
> >  	if (cca.mode == NL802154_CCA_ENERGY_CARRIER) {
> > @@ -653,7 +652,8 @@ static int nl802154_set_cca_mode(struct sk_buff *skb, struct genl_info *info)
> >  			return -EINVAL;
> >  
> >  		cca.opt = nla_get_u32(info->attrs[NL802154_ATTR_CCA_OPT]);
> > -		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX)
> > +		if (cca.opt > NL802154_CCA_OPT_ATTR_MAX ||
> > +		    !(rdev->wpan_phy.supported.cca_opts & BIT(cca.opt)))
> >  			return -EINVAL;
> >  	}
> >  
> > @@ -726,7 +726,11 @@ nl802154_set_backoff_exponent(struct sk_buff *skb, struct genl_info *info)
> >  	max_be = nla_get_u8(info->attrs[NL802154_ATTR_MAX_BE]);
> >  
> >  	/* check 802.15.4 constraints */
> > -	if (max_be < 3 || max_be > 8 || min_be > max_be)
> > +	if (max_be < 3 || max_be > 8 || min_be > max_be ||
> > +	    min_be < rdev->wpan_phy.supported.min_minbe ||
> > +	    min_be > rdev->wpan_phy.supported.max_minbe ||
> > +	    max_be < rdev->wpan_phy.supported.min_maxbe ||
> > +	    max_be > rdev->wpan_phy.supported.max_maxbe)
> >  		return -EINVAL;
> >  
> >  	return rdev_set_backoff_exponent(rdev, wpan_dev, min_be, max_be);
> > @@ -751,7 +755,9 @@ nl802154_set_max_csma_backoffs(struct sk_buff *skb, struct genl_info *info)
> >  			info->attrs[NL802154_ATTR_MAX_CSMA_BACKOFFS]);
> >  
> >  	/* check 802.15.4 constraints */
> > -	if (max_csma_backoffs > 5)
> > +	if (max_csma_backoffs > 5 ||
> > +	    max_csma_backoffs < rdev->wpan_phy.supported.min_csma_backoffs ||
> > +	    max_csma_backoffs > rdev->wpan_phy.supported.max_csma_backoffs)
> >  		return -EINVAL;
> >  
> >  	return rdev_set_max_csma_backoffs(rdev, wpan_dev, max_csma_backoffs);
> > @@ -775,7 +781,9 @@ nl802154_set_max_frame_retries(struct sk_buff *skb, struct genl_info *info)
> >  			info->attrs[NL802154_ATTR_MAX_FRAME_RETRIES]);
> >  
> >  	/* check 802.15.4 constraints */
> > -	if (max_frame_retries < -1 || max_frame_retries > 7)
> > +	if (max_frame_retries < -1 || max_frame_retries > 7 ||
> > +	    max_frame_retries < rdev->wpan_phy.supported.min_frame_retries ||
> > +	    max_frame_retries > rdev->wpan_phy.supported.max_frame_retries)
> >  		return -EINVAL;
> >  
> >  	return rdev_set_max_frame_retries(rdev, wpan_dev, max_frame_retries);
> > @@ -795,6 +803,9 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
> >  		return -EINVAL;
> >  
> >  	mode = !!nla_get_u8(info->attrs[NL802154_ATTR_LBT_MODE]);
> > +	if (mode && !rdev->wpan_phy.supported.lbt)
> > +		return -ENOTSUPP;
> > +
> >  	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
> >  }
> >  
> > diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> > index 8500378..a92eb5f 100644
> > --- a/net/mac802154/main.c
> > +++ b/net/mac802154/main.c
> > @@ -107,6 +107,16 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
> >  
> >  	skb_queue_head_init(&local->skb_queue);
> >  
> > +	/* init supported flags with 802.15.4 constraints */
> > +	phy->supported.max_minbe = 8;
> > +	phy->supported.min_maxbe = 3;
> > +	phy->supported.max_maxbe = 8;
> > +	phy->supported.min_frame_retries = -1;
> > +	phy->supported.max_frame_retries = 7;
> > +	phy->supported.max_csma_backoffs = 5;
> > +	phy->supported.cca_modes = 0xFF;
> > +	phy->supported.cca_opts = 0xFF;
> > +
> >  	return &local->hw;
> >  }
> >  EXPORT_SYMBOL(ieee802154_alloc_hw);
> 
> The question is what transceivers will support all above functionalities..?
> 

This values are all provided by 802.15.4, per default we assume that the
transceiver is fully 802.15.4 complaint and we can change these values. If
not, then the transceiver driver need to overwrite them.

In case of mrf24j40 it only supports the min_be setting. (What I
mentioned in another mail). I suppose that max_be is always be 802.15.4
default. So the driver normally need to set:

phy->supported.min_maxbe = 5;
phy->supported.max_maxbe = 5;

The transceiver can't be working without these configuration (expect the
transceiver doesn't support ARET handling).

We get into trouble on a interface up, when the transceiver doesn't support
802.15.4 default values (because we init our mib with these values).
But I don't think that there are transceivers outside which doesn't
support the 802.15.4 defaults. That also means that every transceiver
supports ARET handling.

What I saw outside of the transceivers world is that not every
transceiver supports every 802.15.4 complaint values, like mrf24j40 for
the max_be value, but at least 802.15.4 defaults.

So we should support "less than 802.15.4 functionality" but not "more
than 802.15.4 functionality". To support more than 802.15.4 I think I
will introduce some vendor nl802154 cmd, it's risky to use values beyond
802.15.4 functionality otherwise others transceivers can run into
troubles.

For cc2520:

I saw none of min_be/max_be setting, to be sure that these values are
default 802.15.4 values (which I suppose) you need to ask ti support.

You need to do something like this:

phy->supported.min_minbe = 3;
phy->supported.max_minbe = 3;
phy->supported.min_maxbe = 5;
phy->supported.max_maxbe = 5;

And add a dummy driver callback. (Maybe we can introduce some dummy
function which can be use by all drivers, if they don't allow to changed
these values).


First look into the datasheet is that it supports ARET and no ARET handling.
This looks much more complicated [0] on page 69. For max_frame_retries
== -1 then it should be the path which describes "No CSMA-CA" and
max_frame_retries => 0 should be the "unslotted csma-ca" mode. Then you
need to do kind of magic with "To retransmit the same frame again, simply
restart TX by issuing a STXON or STXONCCA command strobe." -> see page
68.

For the cca modes it looks like some ENERGY ABOVE THRESHOLD (I would ask
here also the ti support) read page 120. I also advice to always
enable CCA (because the 802.15.4 doesn't describe anything about
CCA_MODE_NONE) otherwise your transceiver running out of spec.


Also for csma_backoffs exists no real configuration, ask ti and do the
same like min/max be. But page 69 describe some "random backoffs" how many
backoffs doesn't describe the datasheet, my guess is it 802.15.4 default
which is 4. And it's random, but we need to know the "max" random
number, but this information isn't shown in the datasheet.

- Alex

[0] http://www.ti.com/lit/ds/symlink/cc2520.pdf
