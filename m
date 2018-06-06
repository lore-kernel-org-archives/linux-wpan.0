Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:45254 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933587AbeFFRxm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Jun 2018 13:53:42 -0400
Date: Wed, 06 Jun 2018 13:53:39 -0400 (EDT)
Message-Id: <20180606.135339.2253125602143741999.davem@davemloft.net>
Subject: Re: [PATCH net] net: ipv6: ip6_output: alloc skb with tailroom
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180605220404.6425-1-aring@mojatatu.com>
References: <20180605220404.6425-1-aring@mojatatu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: aring@mojatatu.com
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, david.palma@ntnu.no, rabinarayans0828@gmail.com, jhs@mojatatu.com, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com

From: Alexander Aring <aring@mojatatu.com>
Date: Tue,  5 Jun 2018 18:04:04 -0400

> This patch adds care about tailroom length for allocate a skb from ipv6
> level stack. In case of 6lowpan we had the problem the skb runs into a
> skb_over_panic() in some special length cases. The root was there was no
> tailroom allocated for the IEEE 802.15.4 checksum, although we had
> the necessary tailroom specified inside the netdev structure.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
> Reported-by: David Palma <david.palma@ntnu.no>
> Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
> Signed-off-by: Alexander Aring <aring@mojatatu.com>

needed_tailroom is an optimization to avoid SKB reallocations
and adjustments, it is not a guarantee.

If you are seeing crashes, it means code is assuming something which
is not to be assumed.

Whatever code is involved, it needs to check that the necessary
tailroom is there and reallocate if necessary, rather than
blindly pushing past the end of the SKB data.

