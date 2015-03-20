Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:36076 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbbCTPaX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Mar 2015 11:30:23 -0400
Received: by wetk59 with SMTP id k59so84920849wet.3
        for <linux-wpan@vger.kernel.org>; Fri, 20 Mar 2015 08:30:22 -0700 (PDT)
Date: Fri, 20 Mar 2015 16:30:20 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 2/3] cc2520: add set transmit power support
Message-ID: <20150320153019.GB3952@omega>
References: <1426836141-21528-1-git-send-email-varkab@cdac.in>
 <1426836141-21528-2-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426836141-21528-2-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi,

On Fri, Mar 20, 2015 at 12:52:19PM +0530, Varka Bhadram wrote:
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  drivers/net/ieee802154/cc2520.c |   56 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index f833b8b..f96cc50 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -53,6 +53,17 @@
>  #define	CC2520_MAXCHANNEL		26
>  #define	CC2520_CHANNEL_SPACING		5
>  
> +/* Tx power values */
> +#define CC2520_TXPOWER_0		0x03 /* -18dbm */
> +#define CC2520_TXPOWER_1		0x2c /* -7dbm */
> +#define CC2520_TXPOWER_2		0x88 /* -4dbm */
> +#define CC2520_TXPOWER_3		0x81 /* -2dbm */
> +#define CC2520_TXPOWER_4		0x32 /* 0dbm */
> +#define CC2520_TXPOWER_5		0x13 /* 1dbm */
> +#define CC2520_TXPOWER_6		0xab /* 2dbm */
> +#define CC2520_TXPOWER_7		0xf2 /* 3dbm */
> +#define CC2520_TXPOWER_8		0xf7 /* 5dbm */
> +
>  /* command strobes */
>  #define	CC2520_CMD_SNOP			0x00
>  #define	CC2520_CMD_IBUFLD		0x02
> @@ -628,6 +639,48 @@ cc2520_filter(struct ieee802154_hw *hw,
>  	return 0;
>  }
>  
> +static int
> +cc2520_set_txpower(struct ieee802154_hw *hw, int db)
> +{

our netlink attribute is s8, maybe we should fix the mac layer at first
and change the int to s8.

- Alex
