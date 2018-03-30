Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:33226 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeC3RBO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 30 Mar 2018 13:01:14 -0400
Date: Fri, 30 Mar 2018 13:01:12 -0400 (EDT)
Message-Id: <20180330.130112.1738302319965874516.davem@davemloft.net>
Subject: Re: pull-request: ieee802154-next 2018-03-29
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180329155138.14417-1-stefan@osg.samsung.com>
References: <20180329155138.14417-1-stefan@osg.samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

From: Stefan Schmidt <stefan@osg.samsung.com>
Date: Thu, 29 Mar 2018 17:51:38 +0200

> An update from ieee802154 for *net-next*
> 
> Colin fixed a unused variable in the new mcr20a driver.
> Harry fixed an unitialised data read in the debugfs interface of the
> ca8210 driver.
> 
> If there are any issues or you think these are to late for -rc1 (both can also
> go into -rc2 as they are simple fixes) let me know.

Pulled into net-next, thanks Stefan.

