Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:37918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeENQNc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 May 2018 12:13:32 -0400
Date: Mon, 14 May 2018 12:13:29 -0400 (EDT)
Message-Id: <20180514.121329.929279497467230317.davem@davemloft.net>
Subject: Re: net: ieee802154: 6lowpan: fix frag reassembly
From: David Miller <davem@davemloft.net>
In-Reply-To: <142208d4-6ca6-5923-327c-8d1cb069ceb8@osg.samsung.com>
References: <142208d4-6ca6-5923-327c-8d1cb069ceb8@osg.samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: stable@vger.kernel.org, aring@mojatatu.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: Stefan Schmidt <stefan@osg.samsung.com>
Date: Mon, 14 May 2018 17:22:18 +0200

> Please apply f18fa5de5ba7f1d6650951502bb96a6e4715a948
> 
> (net: ieee802154: 6lowpan: fix frag reassembly) to the 4.16.x stable tree.
> 
> Earlier trees are not needed as the problem was introduced in 4.16.
> 
> Normally net/ patches would come through DaveM, but he asked me for
> this one to submit it directly when i sent him the pull request.

Stable folks, please queue this up.

Thank you.
