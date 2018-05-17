Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:59682 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeEQOQW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 17 May 2018 10:16:22 -0400
Subject: Re: net: ieee802154: 6lowpan: fix frag reassembly
References: <142208d4-6ca6-5923-327c-8d1cb069ceb8@osg.samsung.com>
 <20180517085919.GD25318@kroah.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <d70c35cd-2795-70f1-a7fc-2785c7938fac@datenfreihafen.org>
Date: Thu, 17 May 2018 16:16:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180517085919.GD25318@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>, Stefan Schmidt <stefan@osg.samsung.com>
Cc: stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>, "David S. Miller" <davem@davemloft.net>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, Network Development <netdev@vger.kernel.org>

Hello Greg.

On 17.05.2018 10:59, Greg KH wrote:
> On Mon, May 14, 2018 at 05:22:18PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>>
>> Please apply f18fa5de5ba7f1d6650951502bb96a6e4715a948
>>
>> (net: ieee802154: 6lowpan: fix frag reassembly) to the 4.16.x stable tree.
>>
>>
>> Earlier trees are not needed as the problem was introduced in 4.16.
> 
> Really?  Commit f18fa5de5ba7 ("net: ieee802154: 6lowpan: fix frag
> reassembly") says it fixes commit 648700f76b03 ("inet: frags: use
> rhashtables for reassembly units") which did not show up until 4.17-rc1:
> 	$ git describe --contains 648700f76b03
> 	v4.17-rc1~148^2~20^2~11
> 
> Also, it did not get backported to 4.16.y, so I don't see how it is
> needed in 4.16-stable.

I guess its time to blush on my side. During the bisection for the
commit that introduced the problem I came to the point where it was
clear to me that it was already in 4.16. This was a while back I have
have honestly no idea how I did this mistake.

I tested again now with plain 4.16 and it works fine.
The fix is also in 4.17-rcX where it actually is needed. In the end I am
glad that it was not introduced and slipped me in an earlier release.

> To verify this, I tried applying the patch, and it totally fails to
> apply to the 4.16.y tree.
> 
> So are you _sure_ you want/need this in 4.16?  If so, can you provide a
> working backport that you have verified works?

No backport needed. I simply screwed up when verifying this for 4.16.
I put on the hat of shame for today and will try harder the next time.

Sorry to have wasted your time on this. :/

regards
Stefan Schmidt
