Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:44669 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbaKMDxY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Nov 2014 22:53:24 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next 0/2] ieee802154: introduce new interframe spacing time handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1415818317-26487-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 13 Nov 2014 12:53:16 +0900
Content-Transfer-Encoding: 8BIT
Message-Id: <AB806B01-2A01-42C7-B0F7-8AF391AB7E33@holtmann.org>
References: <1415818317-26487-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series contains patches for introducing and use of interframe
> spacing time handling. The interframe spacing time handling depends on
> transceiver if it's done at transceiver level or need to be done at SoftMAC
> (mac802154) level. On the at86rf2xx transceiver this is done at transceiver
> when max frame retries is above 0.
> 
> The mac802154 solution is to run a hrtimer which start at complete function.
> When the timer expires we wake the queue again. This stops the transmit queue
> after a transmit for a specific time.
> 
> Currently all drivers except the at86rf230 cares about interframe spacing time.
> I think nobody hit the issue because the latency of workqueue. If we don't making
> interframe spacing time with async xmit handler we run into fragmentation issues
> while 802.15.4 6LoWPAN.
> 
> Alexander Aring (2):
>  mac802154: add interframe spacing time handling
>  at86rf230: remove interframe spacing time workaround
> 
> drivers/net/ieee802154/at86rf230.c | 60 +++++++++++++++++++++++---------------
> include/linux/ieee802154.h         |  3 ++
> include/net/cfg802154.h            |  8 +++++
> include/net/mac802154.h            |  3 +-
> net/mac802154/ieee802154_i.h       |  4 +++
> net/mac802154/iface.c              |  2 ++
> net/mac802154/main.c               | 17 +++++++++++
> net/mac802154/tx.c                 |  2 +-
> net/mac802154/util.c               | 32 ++++++++++++++++++--
> 9 files changed, 103 insertions(+), 28 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

