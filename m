Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:58464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdCMWk1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Mar 2017 18:40:27 -0400
Date: Mon, 13 Mar 2017 15:40:25 -0700 (PDT)
Message-Id: <20170313.154025.2280737153222354061.davem@davemloft.net>
Subject: Re: [PATCH v7 0/6] Bluetooth: 6LoWPAN: Fix lladdr length
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170312081938.11700-1-luiz.dentz@gmail.com>
References: <20170312081938.11700-1-luiz.dentz@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 12 Mar 2017 10:19:32 +0200

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> These patches fixes lladdr length to be 6 bytes long and not 8 which cause
> neighbor advertisement to be sent with wrong lladdr including FF:FE filler
> bytes for eui64.
> 
> Note: This does not fix some of the existing crashes which I hope to address
> in a different set.
> 
> v2: Make all code paths that generate a link-local from lladdr use the same
> code.
> v3: Use lowpan_iphc_uncompress_eui48_lladdr to generate the remote ip address.
> v4: Handle comments from Stefan Schmidt.
> v5: Add patch to fix IID format for Bluetooth
> v6: Fix addrconf_ifid_eui48 to follow IID format for Bluetooth
> v7: Rework addrconf_ifid_6lowpan so it doesn't use addrconf_ifid_eui48

Since this is predominantly bluetooth/6lowpan stuff, please merge this via
the bluetooth tree.

Thanks!
