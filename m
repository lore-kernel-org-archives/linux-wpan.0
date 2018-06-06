Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41462 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932085AbeFFU1A (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Jun 2018 16:27:00 -0400
MIME-Version: 1.0
In-Reply-To: <20180606.141125.1145874895676180399.davem@davemloft.net>
References: <20180605220404.6425-1-aring@mojatatu.com> <20180606.135339.2253125602143741999.davem@davemloft.net>
 <20180606180853.zimcpxbo3ejxum6g@x220t> <20180606.141125.1145874895676180399.davem@davemloft.net>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 6 Jun 2018 16:26:19 -0400
Message-ID: <CAF=yD-L=OF+cBZ1zAeJYtYjR3Zb5jaYTZTk+o6uz+tcnT_-0+Q@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv6: ip6_output: alloc skb with tailroom
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: aring@mojatatu.com, Network Development <netdev@vger.kernel.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, david.palma@ntnu.no, rabinarayans0828@gmail.com, Jamal Hadi Salim <jhs@mojatatu.com>, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com

On Wed, Jun 6, 2018 at 2:11 PM, David Miller <davem@davemloft.net> wrote:
> From: Alexander Aring <aring@mojatatu.com>
> Date: Wed, 6 Jun 2018 14:09:20 -0400
>
>> okay, then you want to have this patch for net-next? As an optimization?
>>
>> Of course, when it's open again.
>
> Like you, I have questions about where this adjustment is applied and
> why.  So I'm not sure yet.
>
> For example, only IPV6 really takes it into consideration and as you
> saw only really for the fragmentation path and not the normal output
> path.
>
> This needs more consideration and investigation.

This is the unconditional skb_put in ieee802154_tx. In many cases
there is some tailroom due to SKB_DATA_ALIGN in __alloc_skb,
so it may take a specific case to not have even 2 bytes of tailroom
available.
