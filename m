Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:32813 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbbDXEne (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Apr 2015 00:43:34 -0400
Received: by pacwv17 with SMTP id wv17so15587565pac.0
        for <linux-wpan@vger.kernel.org>; Thu, 23 Apr 2015 21:43:34 -0700 (PDT)
Message-ID: <5539C9DF.1050501@gmail.com>
Date: Fri, 24 Apr 2015 10:13:11 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [RFC bluetooth-next 15/15] nl802154: add support for dump phy
 capabilities
References: <1429807674-24849-1-git-send-email-alex.aring@gmail.com> <1429807674-24849-16-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1429807674-24849-16-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, phoebe.buckheister@itwm.fraunhofer.de

On 04/23/2015 10:17 PM, Alexander Aring wrote:

> This patch add support to nl802154 to dump all phy capabilities which is
> inside the wpan_phy_supported struct. Also we introduce a new method to
> dumping supported channels. The new method will offer a easier interface
> and has lesser netlink traffic.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  include/net/nl802154.h    |  57 ++++++++++++++++++++
>  net/ieee802154/nl802154.c | 131 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 187 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index 0552771..8c49714 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -100,6 +100,8 @@ enum nl802154_attrs {
>  
>  	NL802154_ATTR_EXTENDED_ADDR,
>  
> +	NL802154_ATTR_WPAN_PHY_CAPS,
> +
>  	/* add attributes here, update the policy in nl802154.c */
>  
>  	__NL802154_ATTR_AFTER_LAST,
> @@ -120,6 +122,61 @@ enum nl802154_iftype {
>  };
>  
>  /**
> + * enum nl802154_wpan_phy_capability_attr - capability attributes
> + *

instead of capability attributes also add wpan phy in-front of it. 

* wpan phy capability attributes *

> + * @__NL802154_CAP_ATTR_INVALID: attribute number 0 is reserved
> + * @NL802154_CAP_ATTR_CHANNELS: a nested attribute for nl802154_channel_attr
> + * @NL802154_CAP_ATTR_TX_POWERS: a nested attribute for
> + *	nl802154_wpan_phy_tx_power
> + * @NL802154_CAP_ATTR_MIN_CCA_ED_LEVEL: minimum value for cca_ed_level
> + * @NL802154_CAP_ATTR_MAX_CCA_ED_LEVEL: maxmimum value for cca_ed_level
> + * @NL802154_CAP_ATTR_CCA_MODES: nl802154_cca_modes flags
> + * @NL802154_CAP_ATTR_CCA_OPTS: nl802154_cca_opts flags
> + * @NL802154_CAP_ATTR_MIN_MINBE: minimum of minbe value
> + * @NL802154_CAP_ATTR_MAX_MINBE: maximum of minbe value
> + * @NL802154_CAP_ATTR_MIN_MAXBE: minimum of maxbe value
> + * @NL802154_CAP_ATTR_MAX_MINBE: maximum of maxbe value
> + * @NL802154_CAP_ATTR_MIN_CSMA_BACKOFFS: minimum of csma backoff value
> + * @NL802154_CAP_ATTR_MAX_CSMA_BACKOFFS: maximum of csma backoffs value
> + * @NL802154_CAP_ATTR_MIN_FRAME_RETRIES: minimum of frame retries value
> + * @NL802154_CAP_ATTR_MAX_FRAME_RETRIES: maximum of frame retries value
> + * @NL802154_CAP_ATTR_IFTYPES: nl802154_iftype flags
> + * @NL802154_CAP_ATTR_LBT: nl802154_supported_bool_states flags
> + * @NL802154_CAP_ATTR_MAX: highest cap attribute currently defined
> + * @__NL802154_CAP_ATTR_AFTER_LAST: internal use
> + */
> +enum nl802154_capability_attr {

enum name mismatch. should be *nl802154_wpan_phy_capability_attr*. 

-- 
Varka Bhadram

