Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:34153 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755516AbbGCWNz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 3 Jul 2015 18:13:55 -0400
Received: by lagx9 with SMTP id x9so97791135lag.1
        for <linux-wpan@vger.kernel.org>; Fri, 03 Jul 2015 15:13:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150703173729.GA2651@omega>
References: <20150701082130.GA1834@omega>
	<CAPpUg6P7ffx8yhcN7Oqjw6uK7-z1mBGNeHXJaBycbkbjYUSK=g@mail.gmail.com>
	<CAPpUg6O6gJ=GTTqxDDY1C85mVSj-R6DSD+XaXwWZ8Zhs4VYT4g@mail.gmail.com>
	<CAPpUg6OiRu2XWb_xMXDVzuSLYP7=JeD1ULcksCh=WjprxxCbKA@mail.gmail.com>
	<20150701151653.GA969@omega>
	<CAPpUg6Obeifuy8eistOir7yjEkZOfbW8WEM8JTJ6v5LwY711EA@mail.gmail.com>
	<20150702161239.GA1258@omega>
	<CAPpUg6MxRFgcwyUfd7joz=7AxtbhUgCdfukthk7qzv5k2ADCCg@mail.gmail.com>
	<20150703154724.GA24800@omega>
	<CAPpUg6NSwRpHQX71jeHqLyvZayVonzBLiwQjh6_MQ+erEcTMxw@mail.gmail.com>
	<20150703173729.GA2651@omega>
Date: Sat, 4 Jul 2015 00:13:53 +0200
Message-ID: <CAPpUg6Pvt6-YQO6aKSC13=+12pbugCoZGCGTJaJV9JG88KHsuQ@mail.gmail.com>
Subject: Re: ping6 doesn't use at86rf230 driver
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

2015-07-03 19:37 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Fri, Jul 03, 2015 at 06:33:01PM +0200, Baptiste Clenet wrote:
>> 2015-07-03 17:47 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
>> > On Fri, Jul 03, 2015 at 03:24:17PM +0200, Baptiste Clenet wrote:
>> > ...
>> >>
>> >> - in at86rf230_async_read_reg, ctx->trx.len = 2 so the spi driver
>> >> receives 0x8100 instead of 0x81 to read TRX_STATUS which results to no
>> >> readings (for me)! The transceiver returns 0
>> >> ---> I set ctx->trx.len to 1 and I receive 8 (TRX_OFF) which seems good.
>> >>
>> >
>> > mhhhh, our buffer for spi_async messages for tx and rx are the same. If
>> > you now look in datasheet [0] at page 18.
>> >
>> > Look at Register Read Access.
>> >
>> > This is always two bytes. On MOSI there is at first byte the
>> > READ_COMMAND then follows on MISO the READ DATA.
>> >
>> >
>> > NOTE:
>> > Now when you spi controller supports full duplex of MISO/MOSI then the
>> > first byte is overwritten by PHY_STATUS.
>> >
>> > You can setup PHY_STATUS at SPI_CMD_MODE which is defaults to "empy, all
>> > bits zero".
>> >
>> > We don't using the PHY_STATUS thing in the driver, because this required
>> > that the spi controller supports full duplex.
>> >
>> > If you say now making ctx->trx.len = 1 solved some issue then I think
>> > the READ_COMMAND will be overwritten by READ DATA. But READ DATA should
>> > be placed after READ_COMMAND (inside the buffer).
>> >
>> > I think regmap uses the same behaviour also because, we set:
>> >
>> > .reg_bits = 8,
>> > .val_bits = 8,
>> >
>> > This exactly means some buffer [ READ_COMMAND (reg_bits) | READ DATA (val_bits)].
>>
>> I definitely agree with all of that and I'm wondering why the spi
>> driver behaves like this (spi-mt7621)
>>
>> > Don't know why it works for regmap and not for spi_async then. For me it
>> > looks like that the first byte which is READ_COMMAND will be overwritten
>> > by READ DATA, but READ DATA should be after READ_COMMAND.
>> >
>> >> -- in at86rf230_async_state_change_start, we check if (trx_state ==
>> >> ctx->to_state), current state are: trx_state 8, ctx->to_state 3, Why
>> >> are we checking if ctx->to_state 3? Because it's impossible to get 3
>> >> in TRX_STATUS, isn't it? So we should check for a 8 here?
>> >>
>> >
>> > Where do we check on to_state 3 which is STATE_FORCE_TRX_OFF.
>>
>> My bad, I didn't see that we change it in at86rf230_async_state_delay:
>> case STATE_FORCE_TRX_OFF:
>>     ctx->to_state = STATE_TRX_OFF;
>>
>
> This is only for make some splitting into one state change define. The
> state status register doesn't know "FORCE_STATE". Only the TRX_CMD to
> initiate the state change knows "doing it with a force change".
>
>> >
>> > - Alex
>> >
>> > [0] http://www.atmel.com/images/atmel-42002-mcu_wireless-at86rf212b_datasheet.pdf
>>
>> I solved my problem by replacing:
>> 1:
>> const u8 trx_state = buf[1] & TRX_STATE_MASK;
>> -->
>> const u8 trx_state = buf[0] & TRX_STATE_MASK;
>> in at86rf230_async_state_assert and
>> at86rf230_async_state_change_start(void *context)
>>
>> 2: add
>> - ctx->trx.len = 1; before ctx->msg.complete = complete; in
>> at86rf230_async_read_reg
>> - ctx->trx.len = 2; before buf[0] = (RG_TRX_STATE & CMD_REG_MASK) |
>> CMD_REG | CMD_WRITE; in at86rf230_async_state_change_start
>
> Ok. I would check all spi_async calls, to read out the IRQ status
> register we use spi_async as well there, not for state change only.

Sure will check that as well!
>
>>
>> I don't get the "unexcept state change from ..." now.
>>
>> First problem seems solved (it's weird but it works, if I've got more
>> time, will debug deeper)
>>
> ok.
>
>> My last problem is when I set the lowpan interface up!
>> The spi driver complains because the message seems too big! The spi
>> driver has got 8 registers of 32 bytes as buffer but the ndisc
>> messages are bigger than that so spi driver raises WARN_ON
>
> What's the spi driver now? You mean spi-mt7621? Your spi controller
> driver? Which WARN_ON do you mean?
>
> If this is you spi controller driver and you cannot send a spi transfer
> messages above 32 bytes -> this is really bad because you need to write
> into the framebuffer of at86rf2xx which is at least (127+3) bytes long
> and I think you cannot write fragments of frames, means start with the
> first, then second, third ... last, which is 32 bytes long (at maximum).
>
> - Alex

Yes spi-mt7621. Warning at line 146 concerning the length of the message [0].
I think I will have to rewrite a bit the driver in order to send more
than 32 Bytes. I think I just need to keep CS pin for the transceiver
low and send all messages in a loop. Will try that on Monday. I will
let you know how it goes.


[0]
https://dev.openwrt.org/browser/trunk/target/linux/ramips/patches-3.18/0061-SPI-ralink-add-mt7621-SoC-spi-driver.patch

Here is the warning:
[  193.320000] ------------[ cut here ]------------
[  193.330000] WARNING: CPU: 0 PID: 175 at
drivers/spi/spi-mt7621.c:146
mt7621_spi_transfer_one_message+0x134/0x448()
[  193.350000] Modules linked in: at86rf230 pppoe ppp_async
iptable_nat pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6
nf_conntrack_ipv4 iph
[  193.560000] CPU: 0 PID: 175 Comm: spi32766 Not tainted 4.0.4 #22
[  193.570000] Stack : 00000000 00000000 00000001 00000000 802b86d4
80311de3 000000af 8035342c
          818ee570 819a2388 819a2200 00000004 80ea450c 80049318
00000003 802bd674
          00000094 819a2388 802bbc78 819bbd7c 80ea450c 8004785c
00000000 00000004
          00000001 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
          ...
[  193.650000] Call Trace:
[  193.650000] [<8001475c>] show_stack+0x48/0x70
[  193.660000] [<80025260>] warn_slowpath_common+0xa0/0xd0
[  193.670000] [<80025318>] warn_slowpath_null+0x18/0x24
[  193.680000] [<801b7ec4>] mt7621_spi_transfer_one_message+0x134/0x448
[  193.690000] [<801b6e4c>] __spi_pump_messages+0x404/0x464
[  193.700000] [<8003ad80>] kthread_worker_fn+0xa8/0xf4
[  193.710000] [<8003aea4>] kthread+0xd8/0xe4
[  193.720000] [<80004878>] ret_from_kernel_thread+0x14/0x1c
[  193.730000]
[  193.730000] ---[ end trace 0d3b96d7ce28c6fc ]---

-- 
Baptiste
