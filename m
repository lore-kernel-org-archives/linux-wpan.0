Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:50051 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638AbcG3V7P (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 30 Jul 2016 17:59:15 -0400
Received: from [IPv6:2003:48:914:7007:3252:cbff:fe54:190f] (p20030048091470073252CBFFFE54190F.dip0.t-ipconnect.de [IPv6:2003:48:914:7007:3252:cbff:fe54:190f])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id B6DDBC0193
	for <linux-wpan@vger.kernel.org>; Sat, 30 Jul 2016 23:51:32 +0200 (CEST)
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: How many devices in an upcoming ATUSB production run?
Message-ID: <3c45f38c-c757-c76c-1f86-c534ac7d0591@datenfreihafen.org>
Date: Sat, 30 Jul 2016 23:51:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

Ever since the first, and only, batch of ATUSB dongles have been sold
out I was looking for someone to get a new batch going to keep this
useful development device available.

For newcomers here or people how are not familiar with it. The ATUSB
dongle is a small USB device with a AVR micro controller and Atmel 15.4
transceiver. The firmware is open source and the kernel driver is
working out of the box in mainline from 4.1. This makes is a nice
development device if you want test 15.4 on your normal laptop or
desktop. Attaching it to a embedded board with USB will also work but if
you have GPIO lines available a transceiver module alone might be cheaper.

Back to the topic. Finally the pieces are coming together and we are
working towards a new batch of devices! Yay! :)

Right now we are thinking of about 50 pieces. Its a device for a very
specific niche after all so its hard to estimate numbers here. If we
would to for 100 or more devices the ratio for the one-time setup costs
in the fab would obviously be better.

Thus I wanted to tru getting some estimation of what we would really
need. What kind of interest is there before we have 99 in stock and only
one sold :)

If you would be interested to get 1 or more of them please let me know
either here or in private. This would not be an order or such, just
shown interest.

The original batch had 120 ATUSB devices and a price tag of 39 EUR for
one ATUSB. With a batch of only 50 we are unable to hold this price tag.
Right now our hope would be to stay below 50 EUR. These prices are not
fixed but our own estimates right now.

If we the interest is high enough and we go with a 100 batch we hope to
reduce the price to 45. And just to make this clear, this does not
include any money for Werner or me putting time into this or the company
making any profit. Its really all for hardware BOM, PCB boards,
manufacturing, webshop handling, etc. All involved parties want to
enable more people having access to this technology and our stack not
making a profit.

http://downloads.qi-hardware.com/people/werner/wpan/web/

Eager so see how much interest is there. :)

regards
Stefan Schmidt
