Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34029 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755474AbbGCPrf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Jul 2015 11:47:35 -0400
Received: by wiar9 with SMTP id r9so134832520wia.1
        for <linux-wpan@vger.kernel.org>; Fri, 03 Jul 2015 08:47:33 -0700 (PDT)
Date: Fri, 3 Jul 2015 17:47:28 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
Message-ID: <20150703154724.GA24800@omega>
References: <20150629220929.GB1165@omega>
 <CAPpUg6N5SAY3fOio7zGnsOPkYytgx5gRgfULO5=6Tz+fcN-9PA@mail.gmail.com>
 <20150701082130.GA1834@omega>
 <CAPpUg6P7ffx8yhcN7Oqjw6uK7-z1mBGNeHXJaBycbkbjYUSK=g@mail.gmail.com>
 <CAPpUg6O6gJ=GTTqxDDY1C85mVSj-R6DSD+XaXwWZ8Zhs4VYT4g@mail.gmail.com>
 <CAPpUg6OiRu2XWb_xMXDVzuSLYP7=JeD1ULcksCh=WjprxxCbKA@mail.gmail.com>
 <20150701151653.GA969@omega>
 <CAPpUg6Obeifuy8eistOir7yjEkZOfbW8WEM8JTJ6v5LwY711EA@mail.gmail.com>
 <20150702161239.GA1258@omega>
 <CAPpUg6MxRFgcwyUfd7joz=7AxtbhUgCdfukthk7qzv5k2ADCCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpUg6MxRFgcwyUfd7joz=7AxtbhUgCdfukthk7qzv5k2ADCCg@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Baptiste Clenet <bapclenet@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

On Fri, Jul 03, 2015 at 03:24:17PM +0200, Baptiste Clenet wrote:
...
> 
> - in at86rf230_async_read_reg, ctx->trx.len = 2 so the spi driver
> receives 0x8100 instead of 0x81 to read TRX_STATUS which results to no
> readings (for me)! The transceiver returns 0
> ---> I set ctx->trx.len to 1 and I receive 8 (TRX_OFF) which seems good.
> 

mhhhh, our buffer for spi_async messages for tx and rx are the same. If
you now look in datasheet [0] at page 18.

Look at Register Read Access.

This is always two bytes. On MOSI there is at first byte the
READ_COMMAND then follows on MISO the READ DATA.


NOTE:
Now when you spi controller supports full duplex of MISO/MOSI then the
first byte is overwritten by PHY_STATUS.

You can setup PHY_STATUS at SPI_CMD_MODE which is defaults to "empy, all
bits zero".

We don't using the PHY_STATUS thing in the driver, because this required
that the spi controller supports full duplex.

If you say now making ctx->trx.len = 1 solved some issue then I think
the READ_COMMAND will be overwritten by READ DATA. But READ DATA should
be placed after READ_COMMAND (inside the buffer).

I think regmap uses the same behaviour also because, we set:

.reg_bits = 8,
.val_bits = 8,

This exactly means some buffer [ READ_COMMAND (reg_bits) | READ DATA (val_bits)].
Don't know why it works for regmap and not for spi_async then. For me it
looks like that the first byte which is READ_COMMAND will be overwritten
by READ DATA, but READ DATA should be after READ_COMMAND.

> -- in at86rf230_async_state_change_start, we check if (trx_state ==
> ctx->to_state), current state are: trx_state 8, ctx->to_state 3, Why
> are we checking if ctx->to_state 3? Because it's impossible to get 3
> in TRX_STATUS, isn't it? So we should check for a 8 here?
> 

Where do we check on to_state 3 which is STATE_FORCE_TRX_OFF.

- Alex

[0] http://www.atmel.com/images/atmel-42002-mcu_wireless-at86rf212b_datasheet.pdf
