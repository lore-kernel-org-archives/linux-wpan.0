Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56390 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbbHFRhV (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 6 Aug 2015 13:37:21 -0400
Subject: Re: [RFCv5 bluetooth-next 4/4] ieee802154: add ack request default
 handling
References: <1438846116-4787-1-git-send-email-alex.aring@gmail.com>
 <1438846116-4787-5-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55C39B4E.1070100@osg.samsung.com>
Date: Thu, 6 Aug 2015 19:37:18 +0200
MIME-Version: 1.0
In-Reply-To: <1438846116-4787-5-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 06/08/15 09:28, Alexander Aring wrote:
> This patch introduce a new mib entry which isn't part of 802.15.4 but
> useful as default behaviour to set the ack request bit or not if we
> don't know if the ack request bit should set. This is currently used for
> stacks like IEEE 802.15.4 6LoWPAN.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   include/net/cfg802154.h     |  5 +++++
>   include/net/nl802154.h      |  4 ++++
>   net/ieee802154/6lowpan/tx.c |  2 +-
>   net/ieee802154/nl802154.c   | 33 +++++++++++++++++++++++++++++++++
>   net/ieee802154/rdev-ops.h   | 13 +++++++++++++
>   net/ieee802154/trace.h      | 19 +++++++++++++++++++
>   net/mac802154/cfg.c         | 11 +++++++++++
>   7 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
> index 382f94b..21353f8 100644
> --- a/include/net/cfg802154.h
> +++ b/include/net/cfg802154.h
> @@ -63,6 +63,8 @@ struct cfg802154_ops {
>   					 s8 max_frame_retries);
>   	int	(*set_lbt_mode)(struct wpan_phy *wpan_phy,
>   				struct wpan_dev *wpan_dev, bool mode);
> +	int	(*set_ackreq_default)(struct wpan_phy *wpan_phy,
> +				      struct wpan_dev *wpan_dev, bool ackreq);
>   };
>   
>   static inline bool
> @@ -193,6 +195,9 @@ struct wpan_dev {
>   	bool lbt;
>   
>   	bool promiscuous_mode;
> +
> +	/* fallback for acknowledgment bit setting */
> +	bool ackreq;
>   };
>   
>   #define to_phy(_dev)	container_of(_dev, struct wpan_phy, dev)
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index b0ab530..cf2713d 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -52,6 +52,8 @@ enum nl802154_commands {
>   
>   	NL802154_CMD_SET_LBT_MODE,
>   
> +	NL802154_CMD_SET_ACKREQ_DEFAULT,
> +
>   	/* add new commands above here */
>   
>   	/* used to define NL802154_CMD_MAX below */
> @@ -104,6 +106,8 @@ enum nl802154_attrs {
>   
>   	NL802154_ATTR_SUPPORTED_COMMANDS,
>   
> +	NL802154_ATTR_ACKREQ_DEFAULT,
> +
>   	/* add attributes here, update the policy in nl802154.c */
>   
>   	__NL802154_ATTR_AFTER_LAST,
> diff --git a/net/ieee802154/6lowpan/tx.c b/net/ieee802154/6lowpan/tx.c
> index 2597abb..1bf4a30 100644
> --- a/net/ieee802154/6lowpan/tx.c
> +++ b/net/ieee802154/6lowpan/tx.c
> @@ -224,7 +224,7 @@ static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
>   	} else {
>   		da.mode = IEEE802154_ADDR_LONG;
>   		da.extended_addr = ieee802154_devaddr_from_raw(daddr);
> -		cb->ackreq = wpan_dev->frame_retries >= 0;
> +		cb->ackreq = wpan_dev->ackreq;
>   	}
>   
>   	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 68f2401..1b00a14 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -230,6 +230,8 @@ static const struct nla_policy nl802154_policy[NL802154_ATTR_MAX+1] = {
>   	[NL802154_ATTR_WPAN_PHY_CAPS] = { .type = NLA_NESTED },
>   
>   	[NL802154_ATTR_SUPPORTED_COMMANDS] = { .type = NLA_NESTED },
> +
> +	[NL802154_ATTR_ACKREQ_DEFAULT] = { .type = NLA_U8 },
>   };
>   
>   /* message building helper */
> @@ -458,6 +460,7 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>   	CMD(set_max_csma_backoffs, SET_MAX_CSMA_BACKOFFS);
>   	CMD(set_max_frame_retries, SET_MAX_FRAME_RETRIES);
>   	CMD(set_lbt_mode, SET_LBT_MODE);
> +	CMD(set_ackreq_default, SET_ACKREQ_DEFAULT);
>   
>   	if (rdev->wpan_phy.flags & WPAN_PHY_FLAG_TXPOWER)
>   		CMD(set_tx_power, SET_TX_POWER);
> @@ -656,6 +659,10 @@ nl802154_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flags,
>   	if (nla_put_u8(msg, NL802154_ATTR_LBT_MODE, wpan_dev->lbt))
>   		goto nla_put_failure;
>   
> +	/* ackreq default behaviour */
> +	if (nla_put_u8(msg, NL802154_ATTR_ACKREQ_DEFAULT, wpan_dev->ackreq))
> +		goto nla_put_failure;
> +
>   	genlmsg_end(msg, hdr);
>   	return 0;
>   
> @@ -1042,6 +1049,24 @@ static int nl802154_set_lbt_mode(struct sk_buff *skb, struct genl_info *info)
>   	return rdev_set_lbt_mode(rdev, wpan_dev, mode);
>   }
>   
> +static int
> +nl802154_set_ackreq_default(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct cfg802154_registered_device *rdev = info->user_ptr[0];
> +	struct net_device *dev = info->user_ptr[1];
> +	struct wpan_dev *wpan_dev = dev->ieee802154_ptr;
> +	bool ackreq;
> +
> +	if (netif_running(dev))
> +		return -EBUSY;

I was not able to change ackreq_default on a running wpan0 interface

root@raspberrypi:~/wpan-tools-0.4# iwpan wpan0 set ackreq_default 1
command failed: Device or resource busy (-16)

Which makes it impossible to change it per frame as you stated in the 
cover letter. I guess this should go.


Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt


