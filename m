Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:56385 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbbHFRhE (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 6 Aug 2015 13:37:04 -0400
Subject: Re: [RFCv5 bluetooth-next 2/4] mac802154: change frame_retries
 behaviour
References: <1438846116-4787-1-git-send-email-alex.aring@gmail.com>
 <1438846116-4787-3-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55C39B3C.5080706@osg.samsung.com>
Date: Thu, 6 Aug 2015 19:37:00 +0200
MIME-Version: 1.0
In-Reply-To: <1438846116-4787-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 06/08/15 09:28, Alexander Aring wrote:
> This patch changes the default minimum value of frame_retries to 0 and
> changes the frame_retries default value to 3 which is also 802.15.4
> default.
>
> We don't use the frame_retries "-1" value as indicator for no-aret mode
> anymore, instead we checking on the ack request bit inside the 802.15.4
> frame control field. This allows a acknowledge handling per frame. This
> checking is done by transceiver or inside xmit callback of driver layer.
>
> If a transceiver doesn't support ARET handling the transmit
> functionality ignores ack frames then, which isn't well but should not
> effect anything of current functionality.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/mac802154/iface.c | 3 +--
>   net/mac802154/main.c  | 9 +++------
>   2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
> index 416de90..8837c5a 100644
> --- a/net/mac802154/iface.c
> +++ b/net/mac802154/iface.c
> @@ -483,8 +483,7 @@ ieee802154_setup_sdata(struct ieee802154_sub_if_data *sdata,
>   	wpan_dev->min_be = 3;
>   	wpan_dev->max_be = 5;
>   	wpan_dev->csma_retries = 4;
> -	/* for compatibility, actual default is 3 */
> -	wpan_dev->frame_retries = -1;
> +	wpan_dev->frame_retries = 3;
>   
>   	wpan_dev->pan_id = cpu_to_le16(IEEE802154_PANID_BROADCAST);
>   	wpan_dev->short_addr = cpu_to_le16(IEEE802154_ADDR_BROADCAST);
> diff --git a/net/mac802154/main.c b/net/mac802154/main.c
> index 9e55431..e8cab5b 100644
> --- a/net/mac802154/main.c
> +++ b/net/mac802154/main.c
> @@ -111,7 +111,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
>   	phy->supported.max_minbe = 8;
>   	phy->supported.min_maxbe = 3;
>   	phy->supported.max_maxbe = 8;
> -	phy->supported.min_frame_retries = -1;
> +	phy->supported.min_frame_retries = 0;
>   	phy->supported.max_frame_retries = 7;
>   	phy->supported.max_csma_backoffs = 5;
>   	phy->supported.lbt = NL802154_SUPPORTED_BOOL_FALSE;
> @@ -177,11 +177,8 @@ int ieee802154_register_hw(struct ieee802154_hw *hw)
>   	}
>   
>   	if (!(hw->flags & IEEE802154_HW_FRAME_RETRIES)) {
> -		/* TODO should be 3, but our default value is -1 which means
> -		 * no ARET handling.
> -		 */
> -		local->phy->supported.min_frame_retries = -1;
> -		local->phy->supported.max_frame_retries = -1;
> +		local->phy->supported.min_frame_retries = 3;
> +		local->phy->supported.max_frame_retries = 3;
>   	}
>   
>   	if (hw->flags & IEEE802154_HW_PROMISCUOUS)

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt


