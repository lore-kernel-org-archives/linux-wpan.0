Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:48401 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752931AbeEIHbQ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 9 May 2018 03:31:16 -0400
Subject: Re: pull-request: ieee802154 2018-05-08
References: <20180508082927.7928-1-s.schmidt@samsung.com>
 <20180508.101808.776198033126419650.davem@davemloft.net>
 <a61fa7c3-fa57-535c-7f00-b495d0a46bb0@osg.samsung.com>
 <20180508.200638.1908252284342544792.davem@davemloft.net>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <460e5002-b5a2-c78b-8727-6692180707f1@osg.samsung.com>
Date: Wed, 9 May 2018 09:31:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180508.200638.1908252284342544792.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: s.schmidt@samsung.com, linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello.


On 05/09/2018 02:06 AM, David Miller wrote:
> From: Stefan Schmidt <stefan@osg.samsung.com>
> Date: Tue, 8 May 2018 21:55:37 +0200
>
>> On 05/08/2018 04:18 PM, David Miller wrote:
>>> Please submit the -stable fix directly, you can feel free to CC: me.
>> Will do when the patch hits Linus git tree.
>>
>> I have a quick question on the process here. From the netdev-faq document
>> I was under the impression all stable patches under net/ and drivers/net
>> should be brought up to you and would be handled by you.
>>
>> Does this apply to the core part of net (I fully understand that ieee802154
>> is rather a niche) or is there some other reason for this exception?
>>
>> Both processes (the normal stable one as well as the slightly different one
>> for net/) would be fine to go with for me. Just need to know which one I
>> should use for future stable patches. :-)
>>
>> regards
>> Stefan Schmidt
> Generally wireless and ipsec have been submitting them directly,
> sometimes the Intel ethernet guys do too.
>
> Sometimes this makes things easier for me, and I'll ask you to submit
> things directly when that is the case like right now.

Thanks for taking the time to explain it. I will go ahead and handle
the stable patches for ieee802154 directly from now on. If you want
to have this changed again just let me know.

regards
Stefan Schmidt
