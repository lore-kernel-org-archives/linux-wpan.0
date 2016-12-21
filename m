Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:19345 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933376AbcLUDLQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 20 Dec 2016 22:11:16 -0500
Date: Wed, 21 Dec 2016 03:11:07 +0000
From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
Subject: Re: [PATCH wpan-tools] wpan-ping: Add the filtering function for
 frame receiving
Message-ID: <20161221031107.GA3877@localhost.localdomain>
References: <1481873430-4965-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
 <5c134ecc-9b51-7a1f-aade-8de517428b8b@osg.samsung.com>
 <20161219023200.GA3609@localhost.localdomain>
 <32ee4024-3e9f-4606-4ebe-3ee2c48a40f0@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ee4024-3e9f-4606-4ebe-3ee2c48a40f0@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, aar@pengutronix.de

Hi,

On Tue, Dec 20, 2016 at 10:01:02AM +0100, Stefan Schmidt wrote:
>Hello.
>
>On 19/12/16 03:32, Xue Wenqian wrote:
>>Hi, Stefan
>>
>>Thank you for your reply.
>>
>>On Fri, Dec 16, 2016 at 02:04:34PM +0100, Stefan Schmidt wrote:
>>>Hello.
>>>
>>>On 16/12/16 08:30, wsn.iot.xwq@cn.fujitsu.com wrote:
>>>>From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
>>>>
>>>>Hi,
>>>>
>>>>Let me make some explanations for the patch:
>>>
>>>No need to start the commit message like a mail. Just the description
>>>is fine. :)
>>>
>>ok, I get it.
>>
>>>>1. The filtering for client is made by checking frame header and sequence number
>>>
>>>Sequence we did before as well so the additional check is for the
>>>header here.
>>>
>>I know the sequence number check you did before, the reason I rewrite
>>here is that when the sequence problem occur, the program will also
>>update new timeout value and receive again until correct frame is
>>received or timeout
>
>OK
>
>
>>>>2. Also, when client receives the incorrect frame, it will update new timeout value and receive again until correct frame is received or timeout
>>>
>>>What happens when a frame is really lost?
>>>
>>First, such doing just tries to avoid a frame lost; Second, it will affect the wpan-ping interval value, since the time consumed for header and sequence number checking maybe large sometimes.
>
>Why would the time to check these to values be long? Even on slow
>hardware this should be fast enough.
>
I made some testing before using RPi-3, treating such frame as lost.
In my testing, the wpan-ping is always running, and the ICMPv6
neighbor solicitation and neighbor advertisement packets are also
transmitted periodically. It is found that the time consumed for
checking header and sequence info may reach 20~30ms, even larger than
100ms, it is unacceptable for me.

>>Our experiment has relatively high requirement for the wpan-ping
>>interval, so I modified the code as such. If you think it is not
>>necessary, I could treat such frame as lost for the patch.
>
>Just send an updated patch with the comments I made before. I will
>give it some testing and let you know if I want anything further
>changed. Thanks.
>
ok, I'll send the patch later as you commented before.
Thank you in advance for the tesing.

regards,
Xue Wenqian


