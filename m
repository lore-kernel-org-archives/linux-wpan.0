Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:60258 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbCNQNi (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 14 Mar 2015 12:13:38 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCHv3 bluetooth-next] ieee802154: correct sifs handling and new defines
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425500399-18438-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 14 Mar 2015 09:13:35 -0700
Content-Transfer-Encoding: 7bit
Message-Id: <014A963E-6174-4DF7-9D28-EA433E4121DD@holtmann.org>
References: <1425500399-18438-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de

Hi Alex,

> this series corrects the interframe spacing time when
> IEEE802154_HW_TX_OMIT_CKSUM phy flag is set. This flag is set when the
> transceiver sets the crc on his own.
> 
> Also I add some defines from 802.15.4 standard. There is still some magic
> values for IEEE802154_FCS_LEN everywhere in mac802154 implementation. We
> should replace these values with IEEE802154_FCS_LEN later.
> 
> - Alex
> 
> changes since v3:
> - squash patch 2 into 1, which was suggested by Marc Kleine-Budde.
> 
> changes since v2:
> - squash patch 3 into 2, which was suggested by Marc Kleine-Budde.
> 
> Alexander Aring (1):
>  mac802154: correct max sifs size handling
> 
> include/linux/ieee802154.h |  2 ++
> net/mac802154/util.c       | 13 ++++++++++++-
> 2 files changed, 14 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

