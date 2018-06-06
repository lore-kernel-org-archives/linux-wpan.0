Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:45656 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbeFFSL2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Jun 2018 14:11:28 -0400
Date: Wed, 06 Jun 2018 14:11:25 -0400 (EDT)
Message-Id: <20180606.141125.1145874895676180399.davem@davemloft.net>
Subject: Re: [PATCH net] net: ipv6: ip6_output: alloc skb with tailroom
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180606180853.zimcpxbo3ejxum6g@x220t>
References: <20180605220404.6425-1-aring@mojatatu.com>
        <20180606.135339.2253125602143741999.davem@davemloft.net>
        <20180606180853.zimcpxbo3ejxum6g@x220t>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aring@mojatatu.com
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, david.palma@ntnu.no, rabinarayans0828@gmail.com, jhs@mojatatu.com, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com

From: Alexander Aring <aring@mojatatu.com>
Date: Wed, 6 Jun 2018 14:09:20 -0400

> okay, then you want to have this patch for net-next? As an optimization?
> 
> Of course, when it's open again.

Like you, I have questions about where this adjustment is applied and
why.  So I'm not sure yet.

For example, only IPV6 really takes it into consideration and as you
saw only really for the fragmentation path and not the normal output
path.

This needs more consideration and investigation.
