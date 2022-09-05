Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84D2ECAAD5
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 03:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiIEDWn (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Sep 2022 23:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDWm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2022 23:22:42 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1B41903E
        for <linux-wpan@vger.kernel.org>; Sun,  4 Sep 2022 20:22:40 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D3F71BF205;
        Mon,  5 Sep 2022 03:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662348159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mKPbqvV42lTxhJAvNntiPBeUBed5OEzUkjDyN6n1NLY=;
        b=knMTMRbpAdJrk7hhSLAGWosEb1CGX0qMnINMJd5+TfjpK6QWiK8e78sQ8MvdwCNouzOH57
        CSHj1UNxIm0ZTOX0wAiPNgX50R9o0pkXBeWB4JNLz7xBXsZYY4Am1ur57YL6WW8g5/wyJG
        XEelXSVeyM5uH4eHTi+/bbSN/gKMTeDV9mQUtGa8U+tRsmAHwRM09+OkbuzQuOQTVHvk0e
        N/ytPQvJtDVBEgSYXHffVDvmbw5t7d7LDfP1WdbYedtI5rDp5IQ00+seza84IXApG68FvM
        Fk8lwwmk19GXHsbU2WQp3W93z/XDQsoZ5+9jW9OiRWqj+0Q5xvoVGPFZ/6NSlw==
Date:   Mon, 5 Sep 2022 05:22:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     stefan@datenfreihafen.org, linux-wpan@vger.kernel.org
Subject: Re: [RFC wpan-next] atusb: add support for trac feature
Message-ID: <20220905052237.513e1889@xps-13>
In-Reply-To: <20220905005544.994036-1-aahringo@redhat.com>
References: <20220905005544.994036-1-aahringo@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Sun,  4 Sep 2022 20:55:44 -0400:

> This patch adds support for reading the trac register if atusb firmware
> reports tx done. There is currently a feature to compare a sequence
> number, if the payload is 1 it tells the driver only the sequence number
> is available if it's two there is additional the trac status register as
> payload.
>=20
> Currently the atusb_in_good() function determines if it's a tx done or
> rx done if according the payload length. This patch is doing the same
> and assumes this behaviour.
>=20
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>=20
> Just an RFC, need another weekend to test it.
>=20
>  drivers/net/ieee802154/atusb.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atus=
b.c
> index 2c338783893d..95a4a3cdc8a4 100644
> --- a/drivers/net/ieee802154/atusb.c
> +++ b/drivers/net/ieee802154/atusb.c
> @@ -191,7 +191,7 @@ static void atusb_work_urbs(struct work_struct *work)
> =20
>  /* ----- Asynchronous USB ----------------------------------------------=
---- */
> =20
> -static void atusb_tx_done(struct atusb *atusb, u8 seq)
> +static void atusb_tx_done(struct atusb *atusb, u8 seq, int reason)
>  {
>  	struct usb_device *usb_dev =3D atusb->usb_dev;
>  	u8 expect =3D atusb->tx_ack_seq;
> @@ -199,7 +199,10 @@ static void atusb_tx_done(struct atusb *atusb, u8 se=
q)
>  	dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, expect);
>  	if (seq =3D=3D expect) {
>  		/* TODO check for ifs handling in firmware */
> -		ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> +		if (reason =3D=3D IEEE802154_SUCCESS)
> +			ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> +		else
> +			ieee802154_xmit_error(atusb->hw, atusb->tx_skb, reason);
>  	} else {
>  		/* TODO I experience this case when atusb has a tx complete
>  		 * irq before probing, we should fix the firmware it's an
> @@ -215,7 +218,8 @@ static void atusb_in_good(struct urb *urb)
>  	struct usb_device *usb_dev =3D urb->dev;
>  	struct sk_buff *skb =3D urb->context;
>  	struct atusb *atusb =3D SKB_ATUSB(skb);
> -	u8 len, lqi;
> +	int result =3D IEEE802154_SUCCESS;
> +	u8 len, lqi, trac;
> =20
>  	if (!urb->actual_length) {
>  		dev_dbg(&usb_dev->dev, "atusb_in: zero-sized URB ?\n");
> @@ -224,8 +228,27 @@ static void atusb_in_good(struct urb *urb)
> =20
>  	len =3D *skb->data;
> =20
> -	if (urb->actual_length =3D=3D 1) {
> -		atusb_tx_done(atusb, len);
> +	switch (urb->actual_length) {
> +	case 2:
> +		trac =3D TRAC_MASK(*(skb->data + 1));

I've been fighting all night thinking the issues were on the atusb side
(it was horribly difficult to get the atusb toolchain up and running,
I'll send a patch to update the instructions), in particular because of
the data[2] definition which needed to be declared static outside of
the functions (see the other mail) and, I guess, because of this
beginner error: I was using skb->data[1] but of course it can't work.

Anyway, this patch works, I've tested it by:
- associating a device (an Arduino Nano running Zephyr, btw)
- having the atusb disassociating the nano successfully (trac =3D 0)
- reassociating the nano
- powering off the nano
- trying to disassociate

The disassociation notification transmission fails with a TRAC status
NO_ACK. So:

Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>

I still have the filtering thing to improve, I'm not sure I'll have
time to do that this week. I need some time to prepare the slides now
that the demo works :)

> +		switch (trac) {
> +		case TRAC_SUCCESS:
> +		case TRAC_SUCCESS_DATA_PENDING:
> +			/* already IEEE802154_SUCCESS */
> +			break;
> +		case TRAC_CHANNEL_ACCESS_FAILURE:
> +			result =3D IEEE802154_CHANNEL_ACCESS_FAILURE;
> +			break;
> +		case TRAC_NO_ACK:
> +			result =3D IEEE802154_NO_ACK;
> +			break;
> +		default:
> +			result =3D IEEE802154_SYSTEM_ERROR;
> +		}
> +
> +		fallthrough;
> +	case 1:
> +		atusb_tx_done(atusb, len, result);
>  		return;
>  	}
> =20


Thanks,
Miqu=C3=A8l
