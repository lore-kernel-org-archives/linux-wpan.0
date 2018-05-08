Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:43090 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbeEHTzn (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 8 May 2018 15:55:43 -0400
Subject: Re: pull-request: ieee802154 2018-05-08
References: <20180508082927.7928-1-s.schmidt@samsung.com>
 <20180508.101808.776198033126419650.davem@davemloft.net>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <a61fa7c3-fa57-535c-7f00-b495d0a46bb0@osg.samsung.com>
Date: Tue, 8 May 2018 21:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180508.101808.776198033126419650.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Miller <davem@davemloft.net>, s.schmidt@samsung.com
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com, netdev@vger.kernel.org

Hello.


On 05/08/2018 04:18 PM, David Miller wrote:
> From: Stefan Schmidt <s.schmidt@samsung.com>
> Date: Tue,  8 May 2018 10:29:27 +0200
>
>> An update from ieee802154 for your *net* tree.
>>
>> Two fixes for the mcr20a driver, which was being added in the 4.17 merge window,
>> by Gustavo and myself.
>> The atusb driver got a change to GFP_KERNEL where no GFP_ATOMIC is needed by
>> Jia-Ju.
>>
>> The last and most important fix is from Alex to get IPv6 reassembly working
>> again for the ieee802154 6lowpan adaptation. This got broken in 4.16 so please
>> queue this one also up for the 4.16 stable tree.
> Pulled, thanks.

Thanks.
>
> Please submit the -stable fix directly, you can feel free to CC: me.

Will do when the patch hits Linus git tree.

I have a quick question on the process here. From the netdev-faq document
I was under the impression all stable patches under net/ and drivers/net
should be brought up to you and would be handled by you.

Does this apply to the core part of net (I fully understand that ieee802154
is rather a niche) or is there some other reason for this exception?

Both processes (the normal stable one as well as the slightly different one
for net/) would be fine to go with for me. Just need to know which one I
should use for future stable patches. :-)

regards
Stefan Schmidt
