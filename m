Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33884 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbaI3Jhn (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 05:37:43 -0400
Received: by mail-pa0-f48.google.com with SMTP id eu11so1508663pac.7
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 02:37:42 -0700 (PDT)
Message-ID: <542A7953.5080306@gmail.com>
Date: Tue, 30 Sep 2014 15:05:15 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <20140929133841.GA15176@omega> <542963F7.4030903@xsilon.com> <20140929135759.GA15411@omega> <542968C5.7000505@xsilon.com> <20140929164157.GA17633@omega> <542A6B15.7060203@xsilon.com> <20140930083835.GA20280@omega> <542A6DF6.809@gmail.com> <20140930085347.GA28060@omega> <542A73A3.5010705@gmail.com> <20140930092550.GB28060@omega>
In-Reply-To: <20140930092550.GB28060@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

On 09/30/2014 02:55 PM, Alexander Aring wrote:
> On Tue, Sep 30, 2014 at 02:40:59PM +0530, Varka Bhadram wrote:
>> Hi Alex,
>>
>>
>> On 09/30/2014 02:23 PM, Alexander Aring wrote:
>>> Hi Varka,
>>>
>>> On Tue, Sep 30, 2014 at 02:16:46PM +0530, Varka Bhadram wrote:
>>>> Alex,
>>>>
>>>> On 09/30/2014 02:09 PM, Alexander Aring wrote:
>>>>> On Tue, Sep 30, 2014 at 09:34:29AM +0100, Simon Vincent wrote:
>>>>>> I can confirm that this fixes the problem. I will create some patches when I
>>>>>> get a chance.
>>>>>> Thanks
>>>>>>
>>>>> This should make trouble on phy's which have no address filter...
>>>> I didnt get what do you mean by this..?
>>>>
>>> The mac802154 address filter sets PACKET_BROADCAST, PACKET_HOST and
>>> PACKET_OTHERHOST. When you have an address filter on PHY, then
>>> PACKET_OTHERHOST should never happen (on good phy's).
>>>
>>> So you always set PACKET_HOST xor PACKET_BROADCAST.
>> Enabling address filtering is in drivers hand..
> no, drivers doesn't parse anything. Address filtering "CAN" done on phy.
> But afterwards we set PACKET_FOO in mac802154 this is another address filtering.
>
> Dropping frames when PACKET_OTHERHOST is part of next layer like (IPv6/6LoWPAN).

For enabling filtering, driver has to update one of the radio chip register.

>> Few hardware devices may not be handling the address filtering (SOftMAC devices).
>> So we need take care of this at Software layers.
>>
> Yes that's what we do mac802154 set PACKET_FOO and next layer will drop
> if it's OTHERHOST.

ok

>>>>> But when IPv6 Layer look on PACKET_BROADCAST then this is also another
>>>>> bug...
>>>>>
>>>>> I did a grep:
>>>>>
>>>>> grep -r "PACKET_BROADCAST" net/IPv6
>>>>>
>>>>> matches on:
>>>>>
>>>>> net/ipv6/mcast.c:	    skb->pkt_type != PACKET_BROADCAST)
>>> 6LoWPAN layer always override the mac802154 parse value to PACKET_HOST.
>>> Now I want to check if IPv6 Layer ever evaluate this value to
>>> PACKET_BROADCAST and yes it seems so. So there is some other bug which
>>> nobody detected.
>>>
>>> Ok?
>> 6LoWPAN layer override the mac802154 parse value to PACKET_HOST, but that you only
>> fixed yesterday. Now we need not to worry about override.
>>
> Of course we need to worry about that, it's not fixed mainline. :-)

Yes.. Simon told that he will generate the patches..

>> Here we need to consider one point. IPv6 layer deals with MUTICAST addresses, there is no
>> broadcast address at this pint.
>>
> In 802.15.4 the MULTICAST in our case is BROADCAST. We don't have any MULTICAST
> feature. Only logical MULTICAST over BROADCAST. If you want to see a L2 Layer with
> multicast support and address filtering on L2 see [0] as ethernet example.

OK..

>> MAC802154 deals with BROADCAST addresses...?
>>
> yes.
>
>> What is the bug that you are talking about..?
>>
> Don't know I didn't hit the bug and doesn't care about that. Point is
> "that skb->pkt_type != PACKET_BROADCAST" is dead code in IPv6 and 6LoWPAN
> because we always setting it to PACKET_HOST.

May be IEEE-802.11 packets send to IPv6 Layer. In that case Its not dead code.

-- 
Regards,
Varka Bhadram.

