Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:58474 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801AbbKQVEp (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 17 Nov 2015 16:04:45 -0500
Subject: Re: [PATCH bluetooth-next 2/2] 6lowpan: iphc: remove handling when
 dam is zero
References: <1447786441-17845-1-git-send-email-alex.aring@gmail.com>
 <1447786441-17845-3-git-send-email-alex.aring@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <564B966A.1070708@osg.samsung.com>
Date: Tue, 17 Nov 2015 22:04:42 +0100
MIME-Version: 1.0
In-Reply-To: <1447786441-17845-3-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de

Hello.

On 17/11/15 19:54, Alexander Aring wrote:
> This patch removes handling of LOWPAN_IPHC_DAM_00 inside the
> lowpan_compress_addr_64 function. The case of LOWPAN_IPHC_DAM_00 can
> never occur. there exists a if branch which use LOWPAN_IPHC_DAM_11 and
> LOWPAN_IPHC_DAM_10 and inside the else branch LOWPAN_IPHC_DAM_01. So
> LOWPAN_IPHC_DAM_00 can never occur.

Agreed the DAM_00 case means no compressions and carry the 128 bit 
address in line. We never call lowpan_compress_addr_64() for this case 
so removing this case which is never used is fine.
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>   net/6lowpan/iphc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 13f5424..f7f175c 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -594,7 +594,6 @@ int lowpan_header_decompress(struct sk_buff *skb, const struct net_device *dev,
>   EXPORT_SYMBOL_GPL(lowpan_header_decompress);
>   
>   static const u8 lowpan_iphc_dam_to_sam_value[] = {
> -	[LOWPAN_IPHC_DAM_00] = LOWPAN_IPHC_SAM_00,
>   	[LOWPAN_IPHC_DAM_01] = LOWPAN_IPHC_SAM_01,
>   	[LOWPAN_IPHC_DAM_10] = LOWPAN_IPHC_SAM_10,
>   	[LOWPAN_IPHC_DAM_11] = LOWPAN_IPHC_SAM_11,
> @@ -603,7 +602,7 @@ static const u8 lowpan_iphc_dam_to_sam_value[] = {
>   static u8 lowpan_compress_addr_64(u8 **hc_ptr, const struct in6_addr *ipaddr,
>   				  const unsigned char *lladdr, bool sam)
>   {
> -	u8 dam = LOWPAN_IPHC_DAM_00;
> +	u8 dam;
>   
>   	if (is_addr_mac_addr_based(ipaddr, lladdr)) {
>   		dam = LOWPAN_IPHC_DAM_11; /* 0-bits */

Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
