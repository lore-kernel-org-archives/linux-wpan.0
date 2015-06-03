Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36829 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbbFCGt5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 02:49:57 -0400
Received: by wgbgq6 with SMTP id gq6so641383wgb.3
        for <linux-wpan@vger.kernel.org>; Tue, 02 Jun 2015 23:49:56 -0700 (PDT)
Date: Wed, 3 Jun 2015 08:49:54 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] nl802154: export supported commands
Message-ID: <20150603064950.GB731@omega>
References: <1433304841-12734-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1433304841-12734-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

On Wed, Jun 03, 2015 at 09:44:01AM +0530, Varka Bhadram wrote:
> This patch will export the supported commands by the devices
> to the user. This is required because user should know supported
> commands by the IEEE-802.15.4 devices. Drivers that are there in
> the mainline are not supporting all the functionalities that the
> core is providing to us.
> 

I think this is not the reason why this was implemented. You check here
cfg802154_ops which ends in mac802154 (SoftMAC) OR _possible_ HardMAC drivers.

If you want to make sure that a driver implement it _and_ really sure
you need to check on ieee802154_ops.

I suppose the real reason why wireless has this implementation, is
because to check if HardMAC drivers can support a specific command.
This is because every HardMAC driver should implement then the full
cfg802154_ops callback structure. It's simple wrong here to say "to
check if the driver support the functionalities".

You skip the mac802154 layer here, these calls are direct driver-layer
calls in case of HardMAC driver only.


Currently that's why I think such feature has _at_ _the_ _moment_ no
really big use case, because we don't have any HardMAC driver currently.
Anyway this prepares to handle HardMAC drivers. After fixing the commit
message you can add a:

Acked-by: Alexander Aring <alex.aring@gmail.com>

> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  include/net/nl802154.h    |    2 ++
>  net/ieee802154/nl802154.c |   36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index 0badebd..6fc231e 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -102,6 +102,8 @@ enum nl802154_attrs {
>  
>  	NL802154_ATTR_WPAN_PHY_CAPS,
>  
> +	NL802154_ATTR_SUPPORTED_COMMANDS,
> +
>  	/* add attributes here, update the policy in nl802154.c */
>  
>  	__NL802154_ATTR_AFTER_LAST,
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 7dbb1f4..310a519 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -372,7 +372,9 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>  				  struct sk_buff *msg, u32 portid, u32 seq,
>  				  int flags)
>  {
> +	struct nlattr *nl_cmds;
>  	void *hdr;
> +	int i;
>  
>  	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
>  	if (!hdr)
> @@ -431,6 +433,40 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>  	if (nl802154_put_capabilities(msg, rdev))
>  		goto nla_put_failure;
>  
> +	nl_cmds = nla_nest_start(msg, NL802154_ATTR_SUPPORTED_COMMANDS);
> +	if (!nl_cmds)
> +		goto nla_put_failure;
> +
> +	i = 0;
> +#define CMD(op, n)							\
> +	do {								\
> +		if (rdev->ops->op) {					\
> +			i++;						\
> +			if (nla_put_u32(msg, i, NL802154_CMD_ ## n))	\
> +				goto nla_put_failure;			\
> +		}							\
> +	} while (0)
> +
> +	CMD(add_virtual_intf, NEW_INTERFACE);
> +	CMD(del_virtual_intf, DEL_INTERFACE);
> +	CMD(set_channel, SET_CHANNEL);
> +	CMD(set_pan_id, SET_PAN_ID);
> +	CMD(set_short_addr, SET_SHORT_ADDR);
> +	CMD(set_backoff_exponent, SET_BACKOFF_EXPONENT);
> +	CMD(set_max_csma_backoffs, SET_MAX_CSMA_BACKOFFS);
> +	CMD(set_max_frame_retries, SET_MAX_FRAME_RETRIES);
> +
> +	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
> +		CMD(set_tx_power, SET_TX_POWER);
> +
> +	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_ED_LEVEL)
> +		CMD(set_cca_ed_level, SET_CCA_ED_LEVEL);
> +
> +	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_CCA_MODE)
> +		CMD(set_cca_mode, SET_CCA_MODE);
> +#undef CMD
> +	nla_nest_end(msg, nl_cmds);
> +
>  finish:
>  	genlmsg_end(msg, hdr);
>  	return 0;
> -- 
> 1.7.9.5
> 
