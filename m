Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:53784 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLKGBI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Dec 2018 01:01:08 -0500
Date: Mon, 10 Dec 2018 22:01:07 -0800 (PST)
Message-Id: <20181210.220107.751606140724107779.davem@davemloft.net>
Subject: Re: [PATCH net-next] ieee802154: ca8210: fix possible u8 overflow
 in ca8210_rx_done
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181211031339.21048-1-yuehaibing@huawei.com>
References: <20181211031339.21048-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: yuehaibing@huawei.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, stefan@datenfreihafen.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 11 Dec 2018 11:13:39 +0800

> gcc warning this:
> 
> drivers/net/ieee802154/ca8210.c:730:10: warning:
>  comparison is always false due to limited range of data type [-Wtype-limits]
> 
> 'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
> This patch change the type of 'len' to unsigned int to avoid this,also fix
> the gcc warning.
> 
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

WPAN maintainers, I am assuming that as maintainers you will be
picking this up and sending it to me.
