Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:57354 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbbATUaa (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Jan 2015 15:30:30 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NIH004MTT5KIQ20@mailout3.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Tue, 20 Jan 2015 20:34:32 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1421784155-2670-1-git-send-email-alex.aring@gmail.com>
In-reply-to: <1421784155-2670-1-git-send-email-alex.aring@gmail.com>
Subject: Re: [PATCHv2 wpan-tools 1/2] interface: remove twice phy information
Date: Tue, 20 Jan 2015 20:30:10 +0000
Message-id: <00b001d034ef$e350dd20$a9f29760$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hello.

On 20/01/15 21:02, Alexander Aring wrote:
> The phy information is already shown in a previous printout and this
> code seems that it was never be functional.
>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   src/interface.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/src/interface.c b/src/interface.c
> index 095753b..904b96e 100644
> --- a/src/interface.c
> +++ b/src/interface.c
> @@ -212,8 +212,6 @@ static int print_iface_handler(struct nl_msg *msg,
> void *arg)
>
> le16toh(nla_get_u16(tb_msg[NL802154_ATTR_PAN_ID])));
>   	if (tb_msg[NL802154_ATTR_IFTYPE])
>   		printf("%s\ttype %s\n", indent,
> iftype_name(nla_get_u32(tb_msg[NL802154_ATTR_IFTYPE])));
> -	if (!wpan_phy && tb_msg[NL802154_ATTR_WPAN_PHY])
> -		printf("%s\twpan_phy %d\n", indent,
> nla_get_u32(tb_msg[NL802154_ATTR_WPAN_PHY]));
>   	if (tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES])
>   		printf("%s\tmax_frame_retries %d\n", indent,
> nla_get_s8(tb_msg[NL802154_ATTR_MAX_FRAME_RETRIES]));
>   	if (tb_msg[NL802154_ATTR_MIN_BE])
>

Reviewed-by: Stefan Schmidt <s.schmidt@samsung.com>

regards
Stefan Schmidt


