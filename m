Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36486 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932586AbeFGQ2y (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 7 Jun 2018 12:28:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180607162233.hepodtvuo7ictel2@x220t>
References: <20180605220404.6425-1-aring@mojatatu.com> <20180606.135339.2253125602143741999.davem@davemloft.net>
 <20180606180853.zimcpxbo3ejxum6g@x220t> <20180606.141125.1145874895676180399.davem@davemloft.net>
 <CAF=yD-L=OF+cBZ1zAeJYtYjR3Zb5jaYTZTk+o6uz+tcnT_-0+Q@mail.gmail.com> <20180607162233.hepodtvuo7ictel2@x220t>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 7 Jun 2018 12:28:12 -0400
Message-ID: <CAF=yD-+DnyjA=8HNhtqCOAx4S0rAmuoj-AvmZH2_JnO_QWjKSg@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv6: ip6_output: alloc skb with tailroom
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aring@mojatatu.com>
Cc: David Miller <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, david.palma@ntnu.no, rabi narayan sahoo <rabinarayans0828@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, stefan@osg.samsung.com, linux-wpan@vger.kernel.org, kernel@mojatatu.com, sd@queasysnail.net

On Thu, Jun 7, 2018 at 12:22 PM, Alexander Aring <aring@mojatatu.com> wrote:
> Hi,
>
> On Wed, Jun 06, 2018 at 04:26:19PM -0400, Willem de Bruijn wrote:
>> On Wed, Jun 6, 2018 at 2:11 PM, David Miller <davem@davemloft.net> wrote:
>> > From: Alexander Aring <aring@mojatatu.com>
>> > Date: Wed, 6 Jun 2018 14:09:20 -0400
>> >
>> >> okay, then you want to have this patch for net-next? As an optimization?
>> >>
>> >> Of course, when it's open again.
>> >
>> > Like you, I have questions about where this adjustment is applied and
>> > why.  So I'm not sure yet.
>> >
>> > For example, only IPV6 really takes it into consideration and as you
>> > saw only really for the fragmentation path and not the normal output
>> > path.
>> >
>> > This needs more consideration and investigation.
>>
>> This is the unconditional skb_put in ieee802154_tx. In many cases
>> there is some tailroom due to SKB_DATA_ALIGN in __alloc_skb,
>> so it may take a specific case to not have even 2 bytes of tailroom
>> available.
>
> Yes it's in ieee802154_tx, but we need tailroom not just for checksum.
> The bugreport is related to the two bytes of tailroom, because virtual
> hardware doing checksum by software. The most real transceivers offload
> this feature, so zero tailroom is needed.
>
> I will of course add checks before adding L2 header for headroom and
> tailroom in related subsystem code.
>
> In IEEE 802.15.4 and secured enabled frames we need a MIC field at the
> end of the frame. In worst case this can be 16 bytes.
>
> I looked ethernet macsec feature and it seems they need to have a similar
> reseved tailroom which is 16 bytes by default (max 32 bytes).

Allocating with necessary tailroom to avoid a realloc in the path
sounds fine to me, too. Packet sockets also take needed_tailroom
into account, to give another example.

We just have to avoid papering over bugs. Fixing the locations that
unconditionally move the tail pointer beyond the allocated
region is more important.
