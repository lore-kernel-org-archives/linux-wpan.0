Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33523 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbEZS1h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 14:27:37 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next 0/6] ieee802154: Assorted fixes and cleanups.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150525123819.GI11340@wantstofly.org>
Date: Tue, 26 May 2015 20:27:34 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <1953A480-DC7C-4CED-A2BB-F12A110DFC10@holtmann.org>
References: <20150525123819.GI11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

> Changes from v1:
> 
> - rebased onto bt-next
> 
> - dropped patches "ieee802154 6lowpan: Don't implement
>  ieee802154_mlme_ops" and "mac802154: mac802154_header_create()
>  optimisation" as they have been obsoleted by some of Alexander's
>  patches that have been applied to bt-next in the meantime
> 
> - added various maintainer ACKs
> 
> I was seeing deadlocks after rebasing onto bt-next, but the cause of
> those is another patch that went into bt-next (see my other email),
> and with a workaround for that issue applied this patchset seems to
> be working OK.
> 
> 
> Lennert Buytenhek (6):
>  ieee802154 socket: Return EMSGSIZE from raw_sendmsg() if packet too
>    big.
>  Documentation/networking/ieee802154.txt: fix various inaccuracies.
>  ieee802154: Remove ieee802154_reduced_mlme_ops references.
>  ieee802154: Remove 802.15.4/6LoWPAN checks for interface MTU.
>  ieee802154 socket: No need to check for ARPHRD_IEEE802154 in
>    raw_bind().
>  mac802154: mac802154_mlme_start_req() optimisation.
> 
> Documentation/networking/ieee802154.txt | 32 +++++++++++---------------------
> include/net/ieee802154_netdev.h         |  6 ------
> net/ieee802154/nl-mac.c                 | 17 +++--------------
> net/ieee802154/socket.c                 |  8 +-------
> net/mac802154/mac_cmd.c                 | 29 +++++++++++------------------
> 5 files changed, 26 insertions(+), 66 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

