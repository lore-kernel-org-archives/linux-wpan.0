Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:43712 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeLJUED (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Dec 2018 15:04:03 -0500
Date: Mon, 10 Dec 2018 12:04:02 -0800 (PST)
Message-Id: <20181210.120402.2087888281534527051.davem@davemloft.net>
Subject: Re: [PATCH net-next] ieee802154: ca8210: remove a dead branch
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181210113443.22796-1-yuehaibing@huawei.com>
References: <20181210113443.22796-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: yuehaibing@huawei.com
Cc: h.morris@cascoda.com, alex.aring@gmail.com, stefan@datenfreihafen.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 10 Dec 2018 19:34:43 +0800

> Fix follwing gcc warning:
> 
> drivers/net/ieee802154/ca8210.c:730:10: warning:
>  comparison is always false due to limited range of data type [-Wtype-limits]
> 
> the variable 'len' is of type u8 and cannot greater than
> CA8210_SPI_BUF_SIZE , which is 256.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Then bug is the variable type here.

We are reading a u8 from buf[], then adding 2, which can overflow.

'len' should be an unsigned int or similar.
