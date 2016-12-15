Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33735 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935391AbcLOK36 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 15 Dec 2016 05:29:58 -0500
Subject: Re: [wpan-tools issue]wpan-ping: recv() function for receiving
 wpan-ping packets
References: <20161214072024.GB5190@localhost.localdomain>
 <8a0c2fd9-1486-240f-5c78-4f7e5bfeb7cc@pengutronix.de>
 <063d658e-0b05-b15a-d497-8440ba839a32@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <7c78e9f9-a863-9efb-8b8c-1466b0587cc1@pengutronix.de>
Date: Thu, 15 Dec 2016 11:29:55 +0100
MIME-Version: 1.0
In-Reply-To: <063d658e-0b05-b15a-d497-8440ba839a32@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: wsn.iot.xwq@cn.fujitsu.com, linux-wpan@vger.kernel.org


Hi,

On 12/15/2016 10:18 AM, Stefan Schmidt wrote:
> Hello.
> 
> On 14/12/16 17:49, Alexander Aring wrote:
>>
>> Hi,
>>
>> On 12/14/2016 08:20 AM, Xue Wenqian wrote:
>>> Hi,
>>>
>>> Recently I find a wpan-ping problem: wpan-ping process is always
>>> running, when there is another process runing on wpan interface, which
>>> will also transmit packets via wpan, the non-wpanping packets will also
>>> be received by recv() of wpan-ping, leading to the "Sequence number did
>>> not match" problem. It seems that the recv() function can not filter out
>>> non-wpanping packets.
> 
> That is correct. Especially on the server side we do no filtering at all and just send back the (hopefully) wpan-ping frame.
> 
> Please go ahead and send your patch with the filtering you suggest and we can discuss what we can take and what not.
> 
> 
>>
>> In my opinion:
>>
>> So the currently known other upper layer protocol is 6LoWPAN. According
>> to 6LoWPAN dispatches [0]:
>>
>> 00 xxxxxx       0       NALP
>>
>> so the wpan-ping dataframe should start with the bit pattern 00.
> 
> That is already done. The wpan-ping packet send out from the client already has this set.
> 

but do you also check on 00 pattern when receiving?

At least you also need to check on ret value if you have seq number
there [0]. I don't see that.

With seq + crc, there could be some __packet__ header struct. :-/
Then check if ret from recv is at least this header long -> otherwise
drop it.

>> Then for extra stuff the payload should do some checksum stuff, e.g.
>> ICMPv6 at tail -> if it doesn't match drop it.
>>
>> Then most frames will be filtered, the rest is the usual header parsing,
>> if it doesn't match there -> drop it.
> 
> As written above nothing is checked or filtered on the server side yet. If there are good suggestions I happily take them in. Let's wait for the patch from Xue to see what he had in mind.
> 

ok.

- Alex

[0] https://github.com/linux-wpan/wpan-tools/blob/master/wpan-ping/wpan-ping.c#L305
