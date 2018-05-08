Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:58624 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755304AbeEHOSJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 8 May 2018 10:18:09 -0400
Date: Tue, 08 May 2018 10:18:08 -0400 (EDT)
Message-Id: <20180508.101808.776198033126419650.davem@davemloft.net>
Subject: Re: pull-request: ieee802154 2018-05-08
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180508082927.7928-1-s.schmidt@samsung.com>
References: <20180508082927.7928-1-s.schmidt@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: s.schmidt@samsung.com
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

From: Stefan Schmidt <s.schmidt@samsung.com>
Date: Tue,  8 May 2018 10:29:27 +0200

> An update from ieee802154 for your *net* tree.
> 
> Two fixes for the mcr20a driver, which was being added in the 4.17 merge window,
> by Gustavo and myself.
> The atusb driver got a change to GFP_KERNEL where no GFP_ATOMIC is needed by
> Jia-Ju.
> 
> The last and most important fix is from Alex to get IPv6 reassembly working
> again for the ieee802154 6lowpan adaptation. This got broken in 4.16 so please
> queue this one also up for the 4.16 stable tree.

Pulled, thanks.

Please submit the -stable fix directly, you can feel free to CC: me.

Thank yuo.
