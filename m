Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34200 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbbG0RnP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jul 2015 13:43:15 -0400
Received: by lafd3 with SMTP id d3so43302142laf.1
        for <linux-wpan@vger.kernel.org>; Mon, 27 Jul 2015 10:43:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150727172816.GB794@omega>
References: <20150727102121.GC18090@omega>
	<CAPpUg6PnmbCitPQTL9YsJqPptnykRn_Nq-xbCYk1yegGwDToMQ@mail.gmail.com>
	<20150727103822.GD18090@omega>
	<CAPpUg6N0K-w_F0My0Wivi7W8MfYee-YSTr=8q2iDuFXFznQbtQ@mail.gmail.com>
	<20150727113054.GE18090@omega>
	<CAPpUg6OLEBfrMx6mA8ZptM-ohqhgbxS-V151hMP4O=61fQMTCw@mail.gmail.com>
	<20150727124220.GF18090@omega>
	<CAPpUg6MDArNF6Rpdv+XgOngFupru+RnEe5ujLgUuMejOmL3Y_w@mail.gmail.com>
	<CAPpUg6OZaGXCXi-K8vW01jtrYbD1ZSHdWCK+FSuAKr-WgQWrEg@mail.gmail.com>
	<CAPpUg6OxkeS4T1vkmdhcL4xYvCp7e-k+SkO2gvxxUOYV6t1qVw@mail.gmail.com>
	<20150727172816.GB794@omega>
Date: Mon, 27 Jul 2015 19:43:13 +0200
Message-ID: <CAPpUg6PbntnvkQjJE=aKgJvsx5w4OKKkRj3_TKRf4AM5VmAJjw@mail.gmail.com>
Subject: Re: What is SAM value? "ieee802154 phy0 wpan0: SAM value 0x3 not supported"
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

2015-07-27 19:28 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> On Mon, Jul 27, 2015 at 05:55:27PM +0200, Baptiste Clenet wrote:
>> 2015-07-27 17:13 GMT+02:00 Baptiste Clenet <bapclenet@gmail.com>:
>> >>> Then forget that and make some at86rf230 driver debug messages. See
>> >>> "print_hex_dump" [0]. Add this add skb->data in at86rf230_xmit and
>> >>> at86rf230_rx_read_frame_complete (but after the skb is filled with data,
>> >>> otherwise it makes no sense).
>> >>>
>> >>> This will allow us to see what's the lowest layer is. If the transmit
>> >>> side looks correct, but receive side looks weird then I suppose
>> >>> something is wrong again with your spi setup.
>> >>>
>> >>> The reason is that we get the lowest dump of the transmitted and
>> >>> received buffer and nobody touched that buffer then.
>> >
>> > I dump the packet in at86rf230_xmit and
>> > at86rf230_rx_read_frame_complete (just before
>> > ieee802154_rx_irqsafe(lp->hw, skb, lqi)). This is wireshark analyse of
>> > the two packets. The first one is correct and comes from the sender,
>> > the second is from the receiver (I manually created the hex dump file)
>> > which is wrong! So something seem to occur when the frame goes to the
>> > transceiver.
>
> ah, sorry I misunderstood you. So you have capture the raw data for
> transmit and receiving and it differs. Then I have still no idea what's
> wrong on your side. :-)
>
> - Alex

Yes it's what I did :-)
But you gave me an idea by saying that I should send only 0xabcd and
see if I receive the same. Which is the easiest way to send 0xabcd as
a raw value? at86rf230_xmit requires struct ieee802154_hw *hw, struct
sk_buff *skb and at86rf230_xmit_start a void *context. Why don't we
have a simple at86rf230_send_raw_data :-)

-- 
Baptiste
