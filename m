Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:47405 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaJBJQo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 05:16:44 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so2617060wgh.4
        for <linux-wpan@vger.kernel.org>; Thu, 02 Oct 2014 02:16:43 -0700 (PDT)
Date: Thu, 2 Oct 2014 11:16:40 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan 1/3] 6lowpan: Ensure pkt_type is not lost
Message-ID: <20141002091638.GB3850@omega>
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com>
 <1412240206-6098-2-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1412240206-6098-2-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, varkabhadram@gmail.com, jukka.rissanen@linux.intel.com

On Thu, Oct 02, 2014 at 09:56:44AM +0100, Simon Vincent wrote:
> Remove line which overrrides pkt_type to PACKET_HOST
> 

s/overrrides/overrides

> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  net/6lowpan/iphc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 142eef5..002cd7c 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -189,7 +189,6 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
>  	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
>  
>  	new->protocol = htons(ETH_P_IPV6);
> -	new->pkt_type = PACKET_HOST;
>  	new->dev = dev;
>  
>  	raw_dump_table(__func__, "raw skb data dump before receiving",
> -- 
> 1.9.1
> 
