Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0704AC38145
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 08:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbiIFIVF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239118AbiIFIVE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Sep 2022 04:21:04 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166343B9
        for <linux-wpan@vger.kernel.org>; Tue,  6 Sep 2022 01:20:58 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E93381BF209;
        Tue,  6 Sep 2022 08:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662452457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvnX6YG/hh5Mz6rKhR9deH75Rb9Tw+qrGDsVN5FoIcU=;
        b=H3fqlBjnPCVxeHbvED4IImftrhdX9VqBKqgesstOwJA6KtARYQBbwwy1xKdWSx40SzQdnx
        zw7RzzAX2/ObZVc2GtlU8+ak6edJ6B6AInd46rCVJDEmEOUDAMj/x/xK4OeicAZ5VFQZOU
        dmkUJQFqgeOkk7pgiuXJC4ZkyZt/jB+dSFG3bsM9aXAuiNDKKs3925gAT4avmZFXvrIlih
        nT/7XKHR+VO51ow0usQqPDVo6o8GJ7HIelYyQ+pk6lyajpML+YBOMD+CwIK+TI+Y3yqCOP
        XgNaJxHXnOzxeNY/PlFlv6d/Hk9sOrpZBNGfDRsxNnNRKPzTYxUvRUHASlk8Sg==
Date:   Tue, 6 Sep 2022 10:20:55 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan@vger.kernel.org, stefan@datenfreihafen.org
Subject: Re: [RFCv2 ben-wpan] fw: add trac reg to tx done
Message-ID: <20220906102055.5698691c@xps-13>
In-Reply-To: <20220906001218.1029787-1-aahringo@redhat.com>
References: <20220906001218.1029787-1-aahringo@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Mon,  5 Sep 2022 20:12:18 -0400:

> This patch adds an additional byte for tx done for the trac status
> register which can then evaluated by the atusb Linux driver.
>=20
> We need to move the transition to RX_AACK_ON after reading the trac
> register value. The current optimization by switchting to RX_AACK_ON
> after invoking transceiver transmission could have the side effect that
> the trac register is not read out before a frame is received. Receiving
> another frame will overwrite the trac register. We can only switch to
> RX_AACK_ON state after we read out the trac register.
> ---
> Not tested yet.
>=20
>  atusb/fw/mac.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
> index 835002c..165ce30 100644
> --- a/atusb/fw/mac.c
> +++ b/atusb/fw/mac.c
> @@ -32,7 +32,7 @@ static uint8_t tx_buf[MAX_PSDU];
>  static uint8_t tx_size =3D 0;
>  static bool txing =3D 0;
>  static bool queued_tx_ack =3D 0;
> -static uint8_t next_seq, this_seq, queued_seq;
> +static uint8_t next_seq, this_seq, this_data[2], queued_data[2];
> =20
> =20
>  /* ----- Receive buffer management -------------------------------------=
---- */
> @@ -65,7 +65,8 @@ static void usb_next(void)
>  	}
> =20
>  	if (queued_tx_ack) {
> -		usb_send(&eps[1], &queued_seq, 1, tx_ack_done, NULL);
> +		usb_send(&eps[1], queued_data, sizeof(queued_data),
> +			 tx_ack_done, NULL);
>  		queued_tx_ack =3D 0;=09
>  	}
>  }
> @@ -124,11 +125,17 @@ static bool handle_irq(void)
> =20
>  	if (txing) {
>  		if (eps[1].state =3D=3D EP_IDLE) {
> -			usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
> +			this_data[0] =3D this_seq;
> +			this_data[1] =3D reg_read(REG_TRX_STATE);
> +			usb_send(&eps[1], this_data, sizeof(this_data),
> +				 tx_ack_done, NULL);
>  		} else {
>  			queued_tx_ack =3D 1;
> -			queued_seq =3D this_seq;
> +			queued_data[0] =3D this_seq;
> +			queued_data[1] =3D reg_read(REG_TRX_STATE);
>  		}
> +		change_state(TRX_CMD_PLL_ON);
> +		change_state(TRX_CMD_RX_AACK_ON);
>  		txing =3D 0;
>  		return 1;
>  	}
> @@ -215,13 +222,6 @@ static void do_tx(void *user)
> =20
>  	txing =3D 1;
>  	this_seq =3D next_seq;
> -
> -	/*
> -	 * Wait until we reach BUSY_TX_ARET, so that we command the transition =
to
> -	 * RX_AACK_ON which will be executed upon TX completion.
> -	 */
> -	change_state(TRX_CMD_PLL_ON);
> -	change_state(TRX_CMD_RX_AACK_ON);

Mmmh, I see. Good catch.

And this patch works.

>  }
> =20
> =20
> @@ -242,7 +242,7 @@ void mac_reset(void)
>  	txing =3D 0;
>  	queued_tx_ack =3D 0;
>  	rx_in =3D rx_out =3D 0;
> -	next_seq =3D this_seq =3D queued_seq =3D 0;
> +	next_seq =3D this_seq =3D queued_data[0], queued_data[1] =3D 0;
> =20
>  	/* enable CRC and PHY_RSSI (with RX_CRC_VALID) in SPI status return */
>  	reg_write(REG_TRX_CTRL_1,


Thanks,
Miqu=C3=A8l
