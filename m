Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56870 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbaITHDf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 20 Sep 2014 03:03:35 -0400
Message-ID: <541D26C5.5010404@xsilon.com>
Date: Sat, 20 Sep 2014 08:03:33 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Promiscuous patches
References: <20140918134210.GB8458@omega> <541AEE07.8030804@xsilon.com> <20140918160458.GB9262@omega> <541B0E3B.9000201@xsilon.com> <20140918170724.GA11661@omega> <20140918175405.GC11661@omega> <20140918175617.GA12638@omega> <541B24CA.1090404@xsilon.com> <20140918185348.GA12931@omega> <20140918203445.GA14182@omega> <20140919101108.GC19085@omega>
In-Reply-To: <20140919101108.GC19085@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Alex,

I noticed the 802.15.4 spec mentions that when promiscuous mode is set 
it zeroes out the source and destination addressing mode of received 
packets which seems to suggest that the packet should not be handled by 
the stack also implying this is a monitor mode. Carry on with your 
design which I've had a chance to look through and it looks great.  I 
can implement whatever I need in a separate debug branch.

- Martin.

On 19/09/14 11:11, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 10:34:45PM +0200, Alexander Aring wrote:
>> On Thu, Sep 18, 2014 at 08:53:48PM +0200, Alexander Aring wrote:
>>> On Thu, Sep 18, 2014 at 07:30:34PM +0100, Martin Townsend wrote:
>>> ...
>>>>> and I hope we clarified now that promiscuous mode with NODE/WPAN type
>>>>> doesn't make any sense than increasing cpu load. You don't get more
>>>>> frames into userspace.
>>>> We are implementing 802.15.4 on powerline.  If we had say a peer to peer
>>>> network involving 4 different PANs and because we aren't restricted by
>>>> distance as much as wireless we could potentially put one of the Coordinator
>>>> nodes into promiscuous mode and then capture traffic from all 4 PAN's
>>>> whereas if we are filtering we only see the traffic for the PAN(s) we are
>>>> involved in.  Wouldn't this be more frames that just the filter?
>>>>
>>> I can't follow, with monitor interface you will get any frame from pans,
>>> also all frame types like ACK's etc... you can also send some frames
>>> (okay the 802.15.4 standard doesn't say that) but at86rf231 seems to
>>> allow this.
>>>
>>> I need to show you moooore implementation details, then you know what a
>>> WPAN/NODE type does on receiving and MONITOR will do on receiving.
>>>
>>> WPAN/NODE/COORD -> have hardwware filtering, addresses, FCS etc..
>>>
>>> MONITOR -> Doesn't filter anything, okay it filters when a SFD was
>>>             receivied but nothing more.
>>>
>>> Now LINUX the "mac802154" does also do filtering stuff, but only on
>>> WPAN/NODE/COORD because these are to interact practical in a network,
>>> not just sniffing.
>>>
>>> On WPAN/NODE/COORD we have filter in mac802154, see [0]. This shows
>>> frame parsing of data frames. You can more look into this how this works.
>>> Now if you have address filter on PHY you will decreasing the load of
>>> mac802154, because most of these frames are already filtered by the phy.
>>>
>>> NOW if you set promiscuous mode on WPAN/NODE you increasing workload but
>>> the most frames will dropped at [0]. You don't get more frames into the
>>> interface (userspace). You only increasing the workload of the cpu.
>>>
>>>
>>> On Monitor interface the PHY doesn't filter anything and the filtering
>>> of [0] is disabled. It's directly send it to the interface so you can
>>> see all frames, also frames which doesn't belong to you.
>>> What a monitor interface does on receiving is [1]. Don't check anything
>>> directly send it to the MONITOR interface. That's why I said "the
>>> monitor interface is a big userspace playground - no filtering on PHY
>>> and kernel is involved".
>>>
>> Is there maybe some practical use for being in promiscuous mode and
>> operate as coordinator/node? Is that what you want?
>>
> I see this could make also big trouble because ACK handling is disabled
> in promiscuous mode. So in ARET networks this could really make trouble.
> On at86rf231 there is a switch to enable/disable ack handling, datasheet
> describes always to disable ACK handling there, need to look what
> 802.15.4-2011 says for this.
>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

