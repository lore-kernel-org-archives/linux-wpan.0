Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61195C4332F
	for <linux-wpan@archiver.kernel.org>; Wed, 12 Oct 2022 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLR6D (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 12 Oct 2022 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJLR5y (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Oct 2022 13:57:54 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C0AFDB45
        for <linux-wpan@vger.kernel.org>; Wed, 12 Oct 2022 10:57:46 -0700 (PDT)
Received: from [IPV6:2003:e9:d728:5820:2c00:8a27:9bcf:7d44] (p200300e9d72858202c008a279bcf7d44.dip0.t-ipconnect.de [IPv6:2003:e9:d728:5820:2c00:8a27:9bcf:7d44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 727B9C0212;
        Wed, 12 Oct 2022 19:57:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1665597464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GnSVbinfAE7Mt7fkno29d7A5Uf9DJBZ/XrFiOX4jcI=;
        b=mDbO8yIxr5WXcmTWLVOYgPnQQhF9P+ULBVqxHmBislqznUFrGRejJbx6te9LSCgpqH5pwX
        sCusyMk0Xl0mWsqevwFpM5Qjbmuvjrsri1I7EBmRc6DTJndADjLlYpJ8WXufu17DC/1yqs
        wbVufWxwYDxNZIWqdQXCuMR0EF+TsruMt6rZJqBqu1nisLwNCmaQ9QSdCsAxvWvbCBQmHB
        LS+Jsg1GKybN4Regmx5nL/+i1d3OfqVk7r3L7yYnVeehEXt1zcAuHn+TOM0ES3wPbOKkl+
        aPyQJQxv0/ezD5YwwQDjJM+SLi4RBirBdR7/u7B9aH6O9U/RRrmSfN1w60kknA==
Message-ID: <c5a7a14f-c92b-cd7c-047a-837b81b19ace@datenfreihafen.org>
Date:   Wed, 12 Oct 2022 19:57:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH atusb/fw v2 3/3] atusb: fw: Provide TRAC status
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>, werner@almesberger.net
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org, Alexander Aring <aahringo@redhat.com>
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
 <20220906082104.1338694-3-miquel.raynal@bootlin.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20220906082104.1338694-3-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 06.09.22 10:21, Miquel Raynal wrote:
> From: Alexander Aring <aahringo@redhat.com>
> 
> Upon Tx done condition, returning the sequence number is useful but we
> might also return the TRAC value which is needed to ensure that the
> packet we sent got ACKed.
> 
> We then need to read the TRAC status register upon Tx completion and
> send this information to the atusb Linux driver as part of the status
> message. First byte remains the sequence number for ensuring backward
> compatibility, a second byte is added to forward the TRAC register
> status.
> 
> We need to move the transition to RX_AACK_ON after reading the trac
> register value. The current optimization by switchting to RX_AACK_ON
> after invoking transceiver transmission could have the side effect that
> the TRAC register is not read out before a frame is received. Receiving
> another frame will overwrite the TRAC register. We can only switch to
> RX_AACK_ON state after we read out the TRAC register.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> [Miquel Raynal: Moved the data array out of the stack, rewrote commit log]
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes since v1:
> * Fix race condition (Rx would mess with the TRAC value, so wait for the
>    transmission to have been signaled and the TRAC register to have been
>    read before changing the state to RX_AACK_ON (by Alexander).
> 
>   atusb/fw/mac.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
> index 835002c..165ce30 100644
> --- a/atusb/fw/mac.c
> +++ b/atusb/fw/mac.c
> @@ -32,7 +32,7 @@ static uint8_t tx_buf[MAX_PSDU];
>   static uint8_t tx_size = 0;
>   static bool txing = 0;
>   static bool queued_tx_ack = 0;
> -static uint8_t next_seq, this_seq, queued_seq;
> +static uint8_t next_seq, this_seq, this_data[2], queued_data[2];
>   
>   
>   /* ----- Receive buffer management ----------------------------------------- */
> @@ -65,7 +65,8 @@ static void usb_next(void)
>   	}
>   
>   	if (queued_tx_ack) {
> -		usb_send(&eps[1], &queued_seq, 1, tx_ack_done, NULL);
> +		usb_send(&eps[1], queued_data, sizeof(queued_data),
> +			 tx_ack_done, NULL);
>   		queued_tx_ack = 0;	
>   	}
>   }
> @@ -124,11 +125,17 @@ static bool handle_irq(void)
>   
>   	if (txing) {
>   		if (eps[1].state == EP_IDLE) {
> -			usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
> +			this_data[0] = this_seq;
> +			this_data[1] = reg_read(REG_TRX_STATE);
> +			usb_send(&eps[1], this_data, sizeof(this_data),
> +				 tx_ack_done, NULL);
>   		} else {
>   			queued_tx_ack = 1;
> -			queued_seq = this_seq;
> +			queued_data[0] = this_seq;
> +			queued_data[1] = reg_read(REG_TRX_STATE);
>   		}
> +		change_state(TRX_CMD_PLL_ON);
> +		change_state(TRX_CMD_RX_AACK_ON);
>   		txing = 0;
>   		return 1;
>   	}
> @@ -215,13 +222,6 @@ static void do_tx(void *user)
>   
>   	txing = 1;
>   	this_seq = next_seq;
> -
> -	/*
> -	 * Wait until we reach BUSY_TX_ARET, so that we command the transition to
> -	 * RX_AACK_ON which will be executed upon TX completion.
> -	 */
> -	change_state(TRX_CMD_PLL_ON);
> -	change_state(TRX_CMD_RX_AACK_ON);
>   }
>   
>   
> @@ -242,7 +242,7 @@ void mac_reset(void)
>   	txing = 0;
>   	queued_tx_ack = 0;
>   	rx_in = rx_out = 0;
> -	next_seq = this_seq = queued_seq = 0;
> +	next_seq = this_seq = queued_data[0], queued_data[1] = 0;
>   
>   	/* enable CRC and PHY_RSSI (with RX_CRC_VALID) in SPI status return */
>   	reg_write(REG_TRX_CTRL_1,

Patch looks good on a first glance. I will need o un-dust my firmware 
repo and get this building and tested here. This will take a few days 
until I find enough time to do that.

Once we are happy with this I can go ahead and cut a v0.4 release and 
make sure it will land on atusb's that get produced after that date.
For the rest I will update the file in linux-firmware to flash.

regards
Stefan Schmidt
