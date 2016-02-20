Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:63962 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbcBTV0z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Feb 2016 16:26:55 -0500
Received: from [192.168.2.105] (pD9E2ADE7.dip0.t-ipconnect.de [217.226.173.231])
	by smtp.strato.de (RZmta 37.19 DYNA|AUTH)
	with ESMTPSA id R06b6fs1KLKZDpY
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <linux-wpan@vger.kernel.org>;
	Sat, 20 Feb 2016 22:20:35 +0100 (CET)
From: smlng <s@mlng.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: extending driver mrf24j40
Message-Id: <1A88240A-AAAD-4243-A31C-61CBC7E8949F@mlng.net>
Date: Sat, 20 Feb 2016 22:20:34 +0100
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi all,

I'm using 2 lowpan transceivers on a Raspberry Pi namely openlabs at86rf233 and microchip mrf24j40ma. I found that the latter one seams to be somewhat _incomplete_, that is it doesn't support handles for _reset_ and _wake/sleep_ gpio-pin configuration. Further, this makes connecting the mrf24j40ma to the RasPi pinout inconvenient (IMHO). On the other hand the atmel driver (at86rf230)[1] does support these functions, so I'd like to _port_ the reset and sleep functionality into the mrf24j40 driver[2]. 

Is anybody working on this, and if not: do you think it is useful/worth while doing so? I'm willing to work on that and implement these extension, maybe also restructure/clean up the driver code a little bit in this process.

So any thoughts on this and/or hints, comments ...

Thanks, best
  Sebastian

[1]: http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/drivers/net/ieee802154/at86rf230.c
[2]: http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/drivers/net/ieee802154/mrf24j40.c