Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47871 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753758AbdKFPgV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:36:21 -0500
Subject: Re: [PATCH 07/14] ieee802154: atusb: switch from BUG_ON() to
 WARN_ON() on problem
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-8-stefan@osg.samsung.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <c165ea45-287f-94a8-2795-bb72147777c8@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:36:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170922121405.31789-8-stefan@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, h.morris@cascoda.com, linuxdev@cascoda.com, varkabhadram@gmail.com, alan@signal11.us

Hello.

On 22.09.2017 14:13, Stefan Schmidt wrote:
> The check is valid but it does not warrant to crash the kernel. A
> WARN_ON() is good enough here.
> Found by checkpatch.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/atusb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 13d8ee5df094..99d40617dc79 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -405,7 +405,7 @@ static int atusb_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
>  
>  static int atusb_ed(struct ieee802154_hw *hw, u8 *level)
>  {
> -	BUG_ON(!level);
> +	WARN_ON(!level);
>  	*level = 0xbe;
>  	return 0;
>  }
> 

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
