Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35703 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbbGZV1m (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Jul 2015 17:27:42 -0400
Received: by wibxm9 with SMTP id xm9so87944725wib.0
        for <linux-wpan@vger.kernel.org>; Sun, 26 Jul 2015 14:27:41 -0700 (PDT)
Received: from omega (p20030064A9060D45E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a906:d45:e2cb:4eff:fe1b:b546])
        by smtp.gmail.com with ESMTPSA id d17sm24357073wjs.32.2015.07.26.14.27.41
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2015 14:27:41 -0700 (PDT)
Date: Sun, 26 Jul 2015 23:27:48 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next 2/4] at86rf230: use aret mode if ackreq is
 set while xmit
Message-ID: <20150726212747.GA27366@omega>
References: <1437945451-8093-1-git-send-email-alex.aring@gmail.com>
 <1437945451-8093-3-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1437945451-8093-3-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

On Sun, Jul 26, 2015 at 11:17:29PM +0200, Alexander Aring wrote:
> This patch does a different aret mode handling. We will drop the
> max_frame_retries "-1" value and check on the ack request bit while
> xmit. If it's set we doing transmit in aret mode. If it's not set we
> doing a transmit in normal tx mode.
> 
> This allows a mixed aret and non aret mode while interface is up and
> doesn't depends on the max_frame_retries value inside the mib.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  drivers/net/ieee802154/at86rf230.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
> index f7bd9f3..3aac100 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -99,7 +99,6 @@ struct at86rf230_local {
>  
>  	bool tx_aret;
>  	unsigned long cal_timeout;
> -	s8 max_frame_retries;
>  	bool is_tx;
>  	bool is_tx_from_off;
>  	u8 tx_retry;
> @@ -900,10 +899,17 @@ at86rf230_xmit(struct ieee802154_hw *hw, struct sk_buff *skb)
>  {
>  	struct at86rf230_local *lp = hw->priv;
>  	struct at86rf230_state_change *ctx = &lp->tx;
> +	__le16 fc;
>  
>  	lp->tx_skb = skb;
>  	lp->tx_retry = 0;
>  
> +	fc = ieee802154_get_fc_from_skb(skb);
> +	if (ieee802154_is_ackreq(fc))
> +		lp->tx_aret = true;
> +	else
> +		lp->tx_aret = false;

doh, I should use here:

lp->tx_aret = ieee802154_is_ackreq(fc);

Anyway it's a RFC only and comments are welcome. ;-)

- Alex
