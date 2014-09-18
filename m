Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63055 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845AbaIRNZS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 09:25:18 -0400
Message-ID: <541ADD3B.8090706@xsilon.com>
Date: Thu, 18 Sep 2014 14:25:15 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: Promiscuous patches
References: <5412F199.7010803@xsilon.com> <20140914234551.GA7009@omega> <541A9E65.3090300@xsilon.com> <20140918094123.GA4350@omega> <541AAE3A.80306@xsilon.com> <20140918104322.GA5217@omega> <541AC962.7090301@xsilon.com> <20140918122140.GA6777@omega> <20140918123024.GB6777@omega> <20140918124430.GA8268@omega>
In-Reply-To: <20140918124430.GA8268@omega>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org


On 18/09/14 13:44, Alexander Aring wrote:
> On Thu, Sep 18, 2014 at 02:30:24PM +0200, Alexander Aring wrote:
>> On Thu, Sep 18, 2014 at 02:21:40PM +0200, Alexander Aring wrote:
>> ...
>>> I think you only want to have a wireshark on a interface.
>>>
>>> wireshark/tcpdump whatever tolds you that the device is into
>>> promiscousmode. But this doesn't change anything also for wireless
>>> (802.11) because the multiple interface types, it's hard to handle it to change
>>> this during runtime. This is some historial issue when you don't have
>>> interface types like ethernet.
>>>
>>>
>>> I think we need to clarify that promiscousmode in a NODE/COORD makes no
>>> sense.
>>>
>>> In userspace what you receive via wireshark/tcpdump makes no different
>>> (should not do any different) if you are in promiscousmode or not. Because
>>> the mac802154 filter packets like when the phy mac filters is
>>> activated.
>>>
>>> If you have a MONITOR type, there is no mac802154 filter activated. And
>>> I mean with mac802154 the stack implementation of Linux kernel.
>>>
>>>
>>> Repeat:
>>>
>>> If you have promiscousmode and NODE/COORD then you only increase the cpu
>>> load and there is (should) no different in userspace by capture with
>>> wireshark/tcpdump. You don't get more frames behind the mac802154 filter.
>>>
>>> On MONITOR type this differs, because you don't have the mac802154 filter.
>>>
>>>
>>> Or I don't understand 100% what you meant here, sorry.
>>>
>> I read now description of [0].
>>
>> And now what 802.15.4-2011 says about the promiscousmode:
>>
>> The second level of filtering shall be dependent on whether the MAC sublayer is currently operating in
>> promiscuous mode. In promiscuous mode, the MAC sublayer shall pass all frames received after the first
>> filter directly to the upper layers without applying any more filtering or processing. The MAC sublayer shall
>> be in promiscuous mode if macPromiscuousMode is set to TRUE.
>>
>> There is lot of other description "simple disable all filtering". There
>> is no word about association with pan'ss.
>>
>> This is for me the MONITOR mode. So MAYBE we could make some MONITOR
>> type which can associated with a PAN and then this can only show PAN
>> traffic. But when we can do this, when we support association with
>> pan's. :-) Then it's like promiscousmode what's desribed at [0].
>>
> or simple change the wireshark filters that you only get frames with
> panid 0xbeef, or something else.
>
> MONITOR and promiscousmode according 802.15.4-2011 simple means, disable
> filtering for me. :/
>
> I really not sure about that I understand what you want to do now with
> promiscousmode.
I want to be able from COORD or NODE mode to put the device in promiscuous mode so packets can be received by wireshark.  For example if we are seeing a problem on a device, I want to be able to ssh into this node via Ethernet (or maybe connect via the serial console) and run tcpdump -U -i wpan0 to help debugging by seeing what packets are being sent/received.  As it's going to stdout it will be sent over ssh and I can then do some pipe redirection to pipe it into Wireshark running on a different machine.

 From my understanding this is not MONITOR mode and I don't won't to put the device into MONITOR mode as this could effect it's functionality.
I'm currently looking at how tcpdump does this and it looks like it uses a raw socket using PF_PACKET.  I think it then sets the IFF_PROMISC flag on this socket to put the device into promiscuous mode.  As I'm in COORD or NODE mode this will arrive at the ndo_change_rx_flags for the net device ops defined in wpan.c not monitor.c in my linux tree.

I notice in your linux-wpan-next alex/wip branch there is no wpan.c or monitor.c, and I can't see how I can be a COORD or NODE and capture packets.

- Martin.


>
> - Alex
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



