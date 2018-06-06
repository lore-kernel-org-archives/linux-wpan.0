Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:32998 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752141AbeFFSJ0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Jun 2018 14:09:26 -0400
Received: by mail-io0-f194.google.com with SMTP id d185-v6so8702743ioe.0
        for <linux-wpan@vger.kernel.org>; Wed, 06 Jun 2018 11:09:26 -0700 (PDT)
Date: Wed, 6 Jun 2018 14:09:20 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH net] net: ipv6: ip6_output: alloc skb with tailroom
Message-ID: <20180606180853.zimcpxbo3ejxum6g@x220t>
References: <20180605220404.6425-1-aring@mojatatu.com>
 <20180606.135339.2253125602143741999.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606.135339.2253125602143741999.davem@davemloft.net>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, yoshfuji@linux-ipv6.org, david.palma@ntnu.no, rabinarayans0828@gmail.com, jhs@mojatatu.com, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi,

On Wed, Jun 06, 2018 at 01:53:39PM -0400, David Miller wrote:
> From: Alexander Aring <aring@mojatatu.com>
> Date: Tue,  5 Jun 2018 18:04:04 -0400
> 
> > This patch adds care about tailroom length for allocate a skb from ipv6
> > level stack. In case of 6lowpan we had the problem the skb runs into a
> > skb_over_panic() in some special length cases. The root was there was no
> > tailroom allocated for the IEEE 802.15.4 checksum, although we had
> > the necessary tailroom specified inside the netdev structure.
> > 
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
> > Reported-by: David Palma <david.palma@ntnu.no>
> > Reported-by: Rabi Narayan Sahoo <rabinarayans0828@gmail.com>
> > Signed-off-by: Alexander Aring <aring@mojatatu.com>
> 
> needed_tailroom is an optimization to avoid SKB reallocations
> and adjustments, it is not a guarantee.
> 

okay, then you want to have this patch for net-next? As an optimization?

Of course, when it's open again.

> If you are seeing crashes, it means code is assuming something which
> is not to be assumed.
> 
> Whatever code is involved, it needs to check that the necessary
> tailroom is there and reallocate if necessary, rather than
> blindly pushing past the end of the SKB data.
> 

I see, I will add checks and reallocs (if necessary) in the underlaying
subsystem level.

Thanks for clarifying this.

- Alex
