Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:36240
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755783AbcLOJSy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Dec 2016 04:18:54 -0500
Subject: Re: [wpan-tools issue]wpan-ping: recv() function for receiving
 wpan-ping packets
References: <20161214072024.GB5190@localhost.localdomain>
 <8a0c2fd9-1486-240f-5c78-4f7e5bfeb7cc@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <063d658e-0b05-b15a-d497-8440ba839a32@osg.samsung.com>
Date: Thu, 15 Dec 2016 10:18:50 +0100
MIME-Version: 1.0
In-Reply-To: <8a0c2fd9-1486-240f-5c78-4f7e5bfeb7cc@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, wsn.iot.xwq@cn.fujitsu.com
Cc: linux-wpan@vger.kernel.org

Hello.

On 14/12/16 17:49, Alexander Aring wrote:
>
> Hi,
>
> On 12/14/2016 08:20 AM, Xue Wenqian wrote:
>> Hi,
>>
>> Recently I find a wpan-ping problem: wpan-ping process is always
>> running, when there is another process runing on wpan interface, which
>> will also transmit packets via wpan, the non-wpanping packets will also
>> be received by recv() of wpan-ping, leading to the "Sequence number did
>> not match" problem. It seems that the recv() function can not filter out
>> non-wpanping packets.

That is correct. Especially on the server side we do no filtering at all 
and just send back the (hopefully) wpan-ping frame.

Please go ahead and send your patch with the filtering you suggest and 
we can discuss what we can take and what not.


>
> In my opinion:
>
> So the currently known other upper layer protocol is 6LoWPAN. According
> to 6LoWPAN dispatches [0]:
>
> 00 xxxxxx       0       NALP
>
> so the wpan-ping dataframe should start with the bit pattern 00.

That is already done. The wpan-ping packet send out from the client 
already has this set.

> Then for extra stuff the payload should do some checksum stuff, e.g.
> ICMPv6 at tail -> if it doesn't match drop it.
>
> Then most frames will be filtered, the rest is the usual header parsing,
> if it doesn't match there -> drop it.

As written above nothing is checked or filtered on the server side yet. 
If there are good suggestions I happily take them in. Let's wait for the 
patch from Xue to see what he had in mind.

Stefan Schmidt
