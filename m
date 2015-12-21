Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34651 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbLULyh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 21 Dec 2015 06:54:37 -0500
Received: by mail-wm0-f44.google.com with SMTP id l126so65351409wml.1
        for <linux-wpan@vger.kernel.org>; Mon, 21 Dec 2015 03:54:37 -0800 (PST)
Date: Mon, 21 Dec 2015 12:54:30 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 1/1] ieee802154-cc2520: Check CRC
Message-ID: <20151221115418.GA3345@omega>
References: <1450660533-38184-1-git-send-email-bradjc5@gmail.com>
 <1450660533-38184-2-git-send-email-bradjc5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1450660533-38184-2-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Hi,

On Sun, Dec 20, 2015 at 08:15:33PM -0500, Brad Campbell wrote:
> Add checking the "CRC_OK" bit at the end of incoming packets to make
> sure the cc2520 driver only passes up valid packets. Because the AUTOCRC
> bit in the FRMCTRL0 register is set to 1 after init, the CC2520 handles
> checking the CRC of incoming packets and sets the most significant bit
> of the last byte of the incoming packet to 1 if the check passed. This
> patch simply checks that bit.
> 
> Signed-off-by: Brad Campbell <bradjc5@gmail.com>
> ---
>  drivers/net/ieee802154/cc2520.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
> index e65b605..b54edbf 100644
> --- a/drivers/net/ieee802154/cc2520.c
> +++ b/drivers/net/ieee802154/cc2520.c
> @@ -450,6 +450,17 @@ cc2520_read_rxfifo(struct cc2520_private *priv, u8 *data, u8 len, u8 *lqi)
>  
>  	mutex_unlock(&priv->buffer_mutex);
>  
> +	/* If we are reading the actual packet and not just the length byte,
> +	 * check that the CRC is valid.
> +	 */
> +	if (len > 1) {
> +		/* Most significant bit of the last byte of the data buffer
> +		 * is a 1 bit CRC indicator. See section 20.3.4.
> +		 */
> +		if (data[len - 1] >> 7 == 0)
> +			return -EINVAL;
> +	}
> +

Doing an access with "len" which I supposed it's the _transmitted_ len
field of PHR, you need to verify the length field that it's not above
127 which is _phy_ mtu length.

The PHR doesn't reach the mac802154 layer, so we always do such
filtering inside the driver layer.

Look for function "ieee802154_is_valid_psdu_len(len)", example [0].

In general "don't use the len PHR field if you don't check if it's
valid". I also don't know what happens when mac802154 get's an skb above
_phy_ mtu. We should filter on this _always_ inside driver-layer after
receiving. The disadvantage is: monitor interfaces doesn't get such
frames, but it's very rarely that a transceiver receive such bad frame.


I would not bet on, that cc2520 does filter the length field. I had
expierence in other transceiver and the most datasheets give not much
information about such handling exactly.

Nevertheless such check doesn't count for performance, simple add such
handling for drop the frame then. :-)

btw:

Why not:

(!(data[len - 1] & BIT(7)))

then BIT(7) is compile time and not doing shifting operation at runtime.

- Alex

[0] http://lxr.free-electrons.com/source/drivers/net/ieee802154/at86rf230.c#L705
