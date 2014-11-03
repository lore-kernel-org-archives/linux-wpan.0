Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:47608 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbaKCRU0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Nov 2014 12:20:26 -0500
Date: Mon, 03 Nov 2014 12:20:24 -0500 (EST)
Message-Id: <20141103.122024.541066618529355652.davem@davemloft.net>
Subject: Re: [PATCH bluetooth-next] netdevice: add ieee802154_ptr to
 net_device
From: David Miller <davem@davemloft.net>
In-Reply-To: <1414907094-9623-1-git-send-email-alex.aring@gmail.com>
References: <1414907094-9623-1-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: alex.aring@gmail.com
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org, linux-wireless@vger.kernel.org

From: Alexander Aring <alex.aring@gmail.com>
Date: Sun,  2 Nov 2014 06:44:54 +0100

> This patch adds an ieee802154_ptr to the net_device structure.
> Furthermore the 802.15.4 subsystem will introduce a nl802154 framework
> which is similar like the nl80211 framework and a wpan_dev structure.
> The wpan_dev structure will hold additional net_device attributes like
> address options which are 802.15.4 specific. In the upcoming nl802154
> implementation we will introduce a NL802154_FLAG_NEED_WPAN_DEV like
> NL80211_FLAG_NEED_WDEV. For this flag an ieee802154_ptr in net_device is
> needed. Additional we can access the wpan_dev attributes in upper layers
> like IEEE 802.15.4 6LoWPAN easily. Current solution is a complicated
> callback interface and getting these values over subif data structure
> in mac802154.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

No objections, and you can merge this via the bluetooth tree:

Acked-by: David S. Miller <davem@davemloft.net>
