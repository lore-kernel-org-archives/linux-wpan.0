Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:55870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdAVVr5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 22 Jan 2017 16:47:57 -0500
Date: Sun, 22 Jan 2017 16:47:55 -0500 (EST)
Message-Id: <20170122.164755.28768525589358817.davem@davemloft.net>
Subject: Re: [PATCH] 6lowpan: use rb_entry()
From: David Miller <davem@davemloft.net>
In-Reply-To: <c6a809ea5820242a4ae126b03cdcd910a36e5cae.1484817152.git.geliangtang@gmail.com>
References: <c6a809ea5820242a4ae126b03cdcd910a36e5cae.1484817152.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: geliangtang@gmail.com
Cc: aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 20 Jan 2017 22:36:53 +0800

> To make the code clearer, use rb_entry() instead of container_of() to
> deal with rbtree.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied.
