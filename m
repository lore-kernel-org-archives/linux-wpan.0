Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56848 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbaJ2WJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 18:09:41 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next 00/17] ieee802154: fix checksum and monitor handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 29 Oct 2014 15:09:37 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <F5521A3F-19FE-4CA4-AB5E-7E824E5372CC@holtmann.org>
References: <1414614884-20243-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series fix checksum and monitor handling. The checksum handling
> is currently a little bit weird, because all driver drops the checksum while
> delivering. In monitor mode we want to see the received checksum. This patch
> series contains various patches to fix the checksum handling and add basic
> support for real monitor mode with promiscuous mode setting.
> 
> The checksum handling is now in some state which should work also for monitor
> interfaces. There exist a better way to add runtime changeable flags to handle
> crc calculation via hardware or software. Also flags like if the monitor
> interface receiving is with or without checksum. This is only to introduce some
> behaviour which should working.
> 
> Alexander Aring (17):
>  mac802154: main: remove unnecessary include
>  mac802154: remove tab after define
>  mac802154: add IEEE802154_HW_ARET hw flag
>  mac802154: add hardware address filter flag
>  mac802154: add support for promiscuous mode
>  at86rf230: add support for promiscuous mode
>  mac802154: separate omit tx/rx flags
>  mac802154: rx: remove unnecessary parameter
>  mac802154: rx: simplify crc receive handling
>  mac802154: rx: add software checksum filtering check
>  mac802154: rx: remove override pkt_type set to PACKET_HOST
>  mac802154: rx: use netif_receive_skb
>  mac802154: rx: add rx stats incrementation
>  mac802154: rx: monitor receive cleanup
>  mac802154: rx: add error handling after skb_clone
>  at86rf230: deliver with checksum
>  mac802154: add basic support for monitor
> 
> drivers/net/ieee802154/at86rf230.c | 35 +++++++++++++++++++--
> drivers/net/ieee802154/cc2520.c    |  3 +-
> drivers/net/ieee802154/mrf24j40.c  |  3 +-
> include/net/mac802154.h            | 40 ++++++++++++++++++------
> net/mac802154/driver-ops.h         | 13 ++++++++
> net/mac802154/ieee802154_i.h       |  1 +
> net/mac802154/iface.c              | 12 ++++++-
> net/mac802154/main.c               |  1 -
> net/mac802154/rx.c                 | 64 +++++++++++++++++++++-----------------
> net/mac802154/tx.c                 |  2 +-
> 10 files changed, 127 insertions(+), 47 deletions(-)

all 17 patches have been applied to bluetooth-next tree.

Regards

Marcel

