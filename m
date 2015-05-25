Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:52519 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbbEYHlf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 May 2015 03:41:35 -0400
Date: Mon, 25 May 2015 10:41:33 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154/atusb: Mark driver as AACK
 enabled in hardware.
Message-ID: <20150525074133.GH11340@wantstofly.org>
References: <1432219897-29528-1-git-send-email-stefan@osg.samsung.com>
 <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432219897-29528-3-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

On Thu, May 21, 2015 at 04:51:36PM +0200, Stefan Schmidt wrote:

> Since firmware version 0.2 we use AACK handling directly in the firmware.
> Inform the stack that the hardware supports and uses it.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> ---
>  drivers/net/ieee802154/atusb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> index 9d07dd7..eef1d8a 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -568,7 +568,8 @@ static int atusb_probe(struct usb_interface *interface,
>  		goto fail;
>  
>  	hw->parent = &usb_dev->dev;
> -	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT;
> +	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
> +		    IEEE802154_HW_AACK;
>  
>  	hw->phy->current_page = 0;
>  	hw->phy->current_channel = 11;	/* reset default */

I'm wondering about this patch...

The IEEE802154_HW_AACK flag is defined in the core:

include/net/mac802154.h:
	/* Indicates that receiver will autorespond with ACK frames. */
	#define IEEE802154_HW_AACK              0x00000002

And is set by various drivers:

drivers/net/ieee802154/at86rf230.c:     lp->hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AACK |
drivers/net/ieee802154/atusb.c:             IEEE802154_HW_AACK;
drivers/net/ieee802154/cc2520.c:        priv->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |
drivers/net/ieee802154/mrf24j40.c:      devrec->hw->flags = IEEE802154_HW_OMIT_CKSUM | IEEE802154_HW_AACK |

But there's no code anywhere in the tree that tests for this flag, and
if I think about it for a bit, I'm not sure what the core code could do
with this information, as I don't think it's feasible to generate ACKs
in software if the hardware doesn't support auto-ACKing?  (Is hardware
that doesn't support this useful or usable at all?  Maybe just remove
the flag altogether?)
