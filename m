Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:57297 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbbHLItv (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 12 Aug 2015 04:49:51 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [RFC 03/16] ieee802154: 6lowpan: remove EXPORT_SYMBOL
References: <1438583035-6287-1-git-send-email-alex.aring@gmail.com>
 <1438583035-6287-4-git-send-email-alex.aring@gmail.com>
Message-ID: <55CB08AC.6090709@osg.samsung.com>
Date: Wed, 12 Aug 2015 10:49:48 +0200
MIME-Version: 1.0
In-Reply-To: <1438583035-6287-4-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de

Hello.

On 03/08/15 08:23, Alexander Aring wrote:
> This function is used internally inside of ieee802154 6lowpan module
> only and not outside of any other module. We don't need to export this
> function then.
>
> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
> ---
>   net/ieee802154/6lowpan/reassembly.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index c9f77f7..cfb8443 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -387,7 +387,6 @@ err:
>   	kfree_skb(skb);
>   	return -1;
>   }
> -EXPORT_SYMBOL(lowpan_frag_rcv);
>   
>   #ifdef CONFIG_SYSCTL
>   static int zero;

Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>

regards
Stefan Schmidt


