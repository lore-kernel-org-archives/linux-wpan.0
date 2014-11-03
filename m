Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47645 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbaKCVfL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 3 Nov 2014 16:35:11 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH bluetooth-next] netdevice: add ieee802154_ptr to net_device
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141103.122024.541066618529355652.davem@davemloft.net>
Date: Mon, 3 Nov 2014 13:35:02 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <F8A94B2C-4EFE-4867-A447-C98ED5142B3B@holtmann.org>
References: <1414907094-9623-1-git-send-email-alex.aring@gmail.com> <20141103.122024.541066618529355652.davem@davemloft.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hi Alex,

>> This patch adds an ieee802154_ptr to the net_device structure.
>> Furthermore the 802.15.4 subsystem will introduce a nl802154 framework
>> which is similar like the nl80211 framework and a wpan_dev structure.
>> The wpan_dev structure will hold additional net_device attributes like
>> address options which are 802.15.4 specific. In the upcoming nl802154
>> implementation we will introduce a NL802154_FLAG_NEED_WPAN_DEV like
>> NL80211_FLAG_NEED_WDEV. For this flag an ieee802154_ptr in net_device is
>> needed. Additional we can access the wpan_dev attributes in upper layers
>> like IEEE 802.15.4 6LoWPAN easily. Current solution is a complicated
>> callback interface and getting these values over subif data structure
>> in mac802154.
>> 
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> 
> No objections, and you can merge this via the bluetooth tree:
> 
> Acked-by: David S. Miller <davem@davemloft.net>

patch has been applied to bluetooth-next tree.

Regards

Marcel

