Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:49973 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbaI3VIk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 17:08:40 -0400
Date: Tue, 30 Sep 2014 17:08:38 -0400 (EDT)
Message-Id: <20140930.170838.555234528916255681.davem@davemloft.net>
Subject: Re: [PATCH 1/1 linux-next] ieee802154: add __init to
 lowpan_frags_sysctl_register
From: David Miller <davem@davemloft.net>
In-Reply-To: <1412109249-7432-1-git-send-email-fabf@skynet.be>
References: <1412109249-7432-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: fabf@skynet.be
Cc: linux-kernel@vger.kernel.org, alex.aring@gmail.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

From: Fabian Frederick <fabf@skynet.be>
Date: Tue, 30 Sep 2014 22:34:08 +0200

> lowpan_frags_sysctl_register is only called by __init lowpan_net_frag_init
> (part of the lowpan module).
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied.
