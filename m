Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61502 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbaIRHzl (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 03:55:41 -0400
Message-ID: <541A8FFA.1010405@xsilon.com>
Date: Thu, 18 Sep 2014 08:55:38 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 6lowpan raw socket problems
References: <5405D961.4060006@xsilon.com> <20140902153742.GC15189@omega> <5405EB08.5040006@xsilon.com> <20140902162630.GD15189@omega> <5406123E.2080100@xsilon.com> <20140908104326.GC6981@omega> <54198CEE.7000906@xsilon.com> <20140917135757.GB14100@omega> <5419A9DD.5070804@xsilon.com> <20140917160353.GC14100@omega> <20140917161723.GE14100@omega>
In-Reply-To: <20140917161723.GE14100@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

We are using kernel 3.16 from davem net-next.

On 17/09/14 17:17, Alexander Aring wrote:
> Hi,
>
> On Wed, Sep 17, 2014 at 06:03:53PM +0200, Alexander Aring wrote:
>> On Wed, Sep 17, 2014 at 04:33:49PM +0100, Simon Vincent wrote:
>>> Hi Alex,
>>>
>>> It looks like the problem is internal to Linux. I am running on a single
>>> Linux box, outputting a RPL message which is put onto a 802154 fakelb
>>> driver. The RPL message is also picked up by the code in my application that
>>> is listening on a RAW socket. This is where the corrupt addresses are seen.
>>>
>>> All addresses are local link. Short addressing is used for the broadcast
>>> address only. I am not using stateful compression.
>>>
>>> Is the same buffer used for the 6lowpan and ipv6 or is a copy taken to do
>>> the ipv6 header compression? If so the message is output on the 802154 but
>>> first the ipv6 header is compressed. The message is also passed to my RAW
>>> ipv6 socket from the ipv6 layer using the same buffer which now contains the
>>> compressed header?
>>>
>>>
>>>                      |--->   recvmsg RAW skt
>>> sendmsg RAW skt --->|
>>>                      |--->   6lowpan/802.15.4
>>>
>>> My debug can see the header getting compressed at the 6lowpan layer but
>> <--- compressed means tx working and no rx.
>>
>>> there is no receive debug triggered so the RAW socket is getting the message
>>> from the ipv6 layer.
>>>
>> mhhh, I have a theory. The linux networking stack is too clever. It see's
>> that these addresses are on the _same_ HOST and running it only one some
>> loopback interfaces. It's like ping6 ::1 on a lowpan interface, if you
>> want to do that, we never replace the IPv6 header with an 6LoWPAN header
>> because the current behaviour doesn't send it to the lower layers.
>> In this case "linux networking stack" see's "ahhh the same host -> doing
>> magic optimization". Then the IPv6 stack doesn't call the necessary
>> callbacks to do 6LoWPAN magic.
>>
>> Please instrument some driver layer of fakelb driver [1] then we can check
>> this theory, When you instrument some printk's at driver layer we can
>> see if your frames ever reached the lower layer. I am right not sure if
>> this could be true, I never tested so much the fakelb driver.
>>
>> Also please instrument this function [0], it's necessary to run
>> decompression when receiving. If my theory is true, then it's a
>> complicated issue and don't know right now a easy workaround.
>>
> I also remembered an other guy/girl which had some issues with 6lowpan
> and fakelb driver, but I did a quick test and it worked for me.
>
> Which kernel version do you using, net-next kernel?
>
> - Alex

