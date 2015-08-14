Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:57112 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbHNHWA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 14 Aug 2015 03:22:00 -0400
Subject: Re: ADF7242 driver ready for mainline inclusion?
References: <55CC5CF3.5030701@sostec.de>
 <78F369B105E123488216BDB7B6C397DAA4DA4FD8@NWD2MBX7.ad.analog.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <55CD9513.8020508@datenfreihafen.org>
Date: Fri, 14 Aug 2015 09:13:23 +0200
MIME-Version: 1.0
In-Reply-To: <78F369B105E123488216BDB7B6C397DAA4DA4FD8@NWD2MBX7.ad.analog.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Alexander Aring <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

On 13/08/15 20:50, Hennerich, Michael wrote:
> Hi All,
>
> I did tis driver a long time ago, when the Linux 802.15.4 support in general was at its beginning and pretty broken as well.
> From time to time I update this driver - and actually it's pretty mature - and should apply to mainline without problems.
>
> There is currently only one minor thing that I wanted to investigate (some ifdef in the ISR) before submitting the driver mainline.

This is great to hear! Looking forward to it. :)
> Are you using the ADF7242 in a design already?

No. The reason I wrote this is that I have an interest in the linux-wpan
subsystem in general and thought the driver would be a good candidate
for mainline.

I actually searched for some simple ADF7242which I could hook up to SPI
+ IRQ and maybe some more control lines. So far I only found the
official evaluation board which is to expensive for some hobbyist testing.
> Do you have feedback already?

The driver interface for ieee802154 has advanced since the it got merged
initially. Some of the new things you might want to look into and add
support are:

o Async transmit (xmit_async)
o LBT support (set_lbt)
o Set CC mode and ed level (set_cc_mode, set_cca_ed_level)
o Support for monitor mode (set_promiscuous_mode)

These I found missing when having a brief look over the driver.

regards
Stefan Schmidt

