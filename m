Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58993 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbbHUHhY (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 21 Aug 2015 03:37:24 -0400
Subject: Re: [PATCH wpan-tools] mac/py: add range checks on arguments to avoid
 wrong value being set
References: <1440068315-7974-1-git-send-email-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <55D6D52D.1070203@osg.samsung.com>
Date: Fri, 21 Aug 2015 09:37:18 +0200
MIME-Version: 1.0
In-Reply-To: <1440068315-7974-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hello.

On 20/08/15 12:58, Stefan Schmidt wrote:
> While we do more input validation on the kernel level we have to check for
> overruns here as this would be to late on kernel level. An example would be
> setting ackreq_default to 257 which would come as 0 to the kernel netlink
> API due to it being u8. To avoid this we check for args over maximum and
> reject them here. Rest of input validation stay in kernel.
>
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>   src/mac.c | 21 +++++++++++++++++++++
>   src/phy.c |  3 +++
>   2 files changed, 24 insertions(+)
>
> diff --git a/src/mac.c b/src/mac.c
> index 76db58f..286802c 100644
> --- a/src/mac.c
> +++ b/src/mac.c
> @@ -30,6 +30,9 @@ static int handle_pan_id_set(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (pan_id > UINT16_MAX)
> +		return 1;
> +
>   	NLA_PUT_U16(msg, NL802154_ATTR_PAN_ID, htole16(pan_id));
>   
>   	return 0;
> @@ -57,6 +60,9 @@ static int handle_short_addr_set(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (short_addr > UINT16_MAX)
> +		return 1;
> +
>   	NLA_PUT_U16(msg, NL802154_ATTR_SHORT_ADDR, htole16(short_addr));
>   
>   	return 0;
> @@ -84,6 +90,9 @@ static int handle_max_frame_retries_set(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (retries > INT8_MAX)
> +		return 1;
> +
>   	NLA_PUT_S8(msg, NL802154_ATTR_MAX_FRAME_RETRIES, retries);
>   
>   	return 0;
> @@ -118,6 +127,9 @@ static int handle_backoff_exponent(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (min_be > UINT8_MAX || max_be > UINT8_MAX)
> +		return 1;
> +
>   	NLA_PUT_U8(msg, NL802154_ATTR_MIN_BE, min_be);
>   	NLA_PUT_U8(msg, NL802154_ATTR_MAX_BE, max_be);
>   
> @@ -147,6 +159,9 @@ static int handle_max_csma_backoffs(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (backoffs > UINT8_MAX)
> +		return 1;
> +
>   	NLA_PUT_U8(msg, NL802154_ATTR_MAX_CSMA_BACKOFFS, backoffs);
>   
>   	return 0;
> @@ -176,6 +191,9 @@ static int handle_lbt_mode(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (mode > UINT8_MAX)
> +		return 1;
> +
>   	NLA_PUT_U8(msg, NL802154_ATTR_LBT_MODE, mode);
>   
>   	return 0;
> @@ -203,6 +221,9 @@ static int handle_ackreq_default(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (ackreq > UINT8_MAX)
> +		return 1;
> +
>   	NLA_PUT_U8(msg, NL802154_ATTR_ACKREQ_DEFAULT, ackreq);
>   
>   	return 0;
> diff --git a/src/phy.c b/src/phy.c
> index 8adffcc..816bdd8 100644
> --- a/src/phy.c
> +++ b/src/phy.c
> @@ -36,6 +36,9 @@ static int handle_channel_set(struct nl802154_state *state,
>   	if (*end != '\0')
>   		return 1;
>   
> +	if (page > UINT8_MAX || channel > UINT8_MAX)
> +		return 1;
> +
>   	NLA_PUT_U8(msg, NL802154_ATTR_PAGE, page);
>   	NLA_PUT_U8(msg, NL802154_ATTR_CHANNEL, channel);
>   

Pushed to the repo.

regards
Stefan Schmidt

