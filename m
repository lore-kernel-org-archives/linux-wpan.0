Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:53240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeCIQTV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Mar 2018 11:19:21 -0500
Date: Fri, 09 Mar 2018 11:19:19 -0500 (EST)
Message-Id: <20180309.111919.311394036748274102.davem@davemloft.net>
Subject: Re: [PATCH net] ieee802154: 6lowpan: fix possible NULL deref in
 lowpan_device_event()
From: David Miller <davem@davemloft.net>
In-Reply-To: <137aa8f3-c10a-a85f-509b-65d77aeb2a70@osg.samsung.com>
References: <1520268663.109662.5.camel@gmail.com>
        <99cd0859-4d7a-92a2-03e6-f0ab7daf2bc8@osg.samsung.com>
        <137aa8f3-c10a-a85f-509b-65d77aeb2a70@osg.samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: eric.dumazet@gmail.com, netdev@vger.kernel.org, alex.aring@gmail.com, linux-wpan@vger.kernel.org

From: Stefan Schmidt <stefan@osg.samsung.com>
Date: Thu, 8 Mar 2018 17:21:49 +0100

> Did you miss this or would you prefer if I do a pull request for
> this single patch?  Either way would be fine with me.

Sorry, this escaped me.

Applied and queued up for -stable, thanks.
