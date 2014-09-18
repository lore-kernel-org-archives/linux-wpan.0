Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51691 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757643AbaIRWzt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Thu, 18 Sep 2014 18:55:49 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway2.nyi.internal (Postfix) with ESMTP id C88DB20A93
	for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 18:55:48 -0400 (EDT)
Message-ID: <541B62F6.7000506@signal11.us>
Date: Thu, 18 Sep 2014 18:55:50 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] ieee802154: mrf24j40: remove return
 statement
References: <1410842922-10564-1-git-send-email-varkab@cdac.in> <1410842922-10564-3-git-send-email-varkab@cdac.in>
In-Reply-To: <1410842922-10564-3-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: Varka Bhadram <varkab@cdac.in>

Make the first line of the commit message:
	mrf24j40: remove unnecessary return statement

On 09/16/2014 12:48 AM, Varka Bhadram wrote:
> This patch remove the return statement for void function.
> void function return statements are not generally useful.
>

Take out "this patch" and the second line. Make the comment:

	Remove the return statement in the void function.


> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   drivers/net/ieee802154/mrf24j40.c |    2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
> index 466da57..2c617e3 100644
> --- a/drivers/net/ieee802154/mrf24j40.c
> +++ b/drivers/net/ieee802154/mrf24j40.c
> @@ -420,8 +420,6 @@ static void mrf24j40_stop(struct ieee802154_dev *dev)
>   		return;
>   	val |= 0x1|0x8; /* Set TXNIE and RXIE. Disable Interrupts */
>   	write_short_reg(devrec, REG_INTCON, val);
> -
> -	return;
>   }
>
>   static int mrf24j40_set_channel(struct ieee802154_dev *dev,
>

