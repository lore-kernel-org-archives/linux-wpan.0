Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59932 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbFRPCX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 11:02:23 -0400
Message-ID: <5582DD7B.6090907@xsilon.com>
Date: Thu, 18 Jun 2015 16:02:19 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: 802.15.4 security
References: <555DDC3E.6090203@xsilon.com>	<20150528110026.70a44e0d@zoidberg>	<55829983.3080608@xsilon.com>	<20150618131330.6bc2f488@zoidberg> <20150618134013.2a035f46@zoidberg>
In-Reply-To: <20150618134013.2a035f46@zoidberg>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

I have managed to get security working now in all modes.

I will submit a patch to fix the scatterlist bug.

The other problem I had was the IV was being generated incorrectly. This 
was because I had used the iwpan tools to set the mac address. This does 
not set the ieee802154_llsec_params.hwaddr[1] which is used for creating 
the IV.[2]

I am not sure the best way to fix this issue. Do we need to keep to keep 
a copy of the pan_id, hwaddr, coord_hwaddr, coord_shortaddr in the 
llsec_params? It seems like it could easily get missed and not updated 
if one of these parameters change.

Simon

[1] - 
http://lxr.free-electrons.com/source/include/net/ieee802154_netdev.h#L308
[2] - http://lxr.free-electrons.com/source/net/mac802154/llsec.c#L627 
and http://lxr.free-electrons.com/source/net/mac802154/llsec.c#L656

On 18/06/15 12:40, Phoebe Buckheister wrote:
> Found the bug for levels 1,2,3:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/net/mac802154/llsec.c#n680
>
> Scatterlist length 0 is invalid. If I had properly built the
> scatterlists properly instead of setting single element lengths to 0
> (because I thought that was allowed), things wouldn't die in a BUG().
> Can't patch that now, though, I'm sorry :(
>
> On Thu, 18 Jun 2015 13:13:30 +0200
> Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de> wrote:
>
>> Hi Simon,
>>
>> the last kernel I used this with was 3.15-rc8, so actually quite a
>> while ago. Unfortunately, I don't have the means to test things with a
>> current kernel right now, because I don't remember things failing that
>> hard when I last worked on that code. I usually used seclevel 5, which
>> worked fine with our devices.
>>
>> @wireshark: by default, without further configuration, wireshark can't
>> check the MIC, because it doesn't have the necessary keys. There was a
>> way to give wireshark those keys, but I don't remember off hand how
>> that worked.
>>
>> On Thu, 18 Jun 2015 11:12:19 +0100
>> Simon Vincent <simon.vincent@xsilon.com> wrote:
>>
>>> Hi Phoebe,
>>>
>>> I am having some problems with the 802.15.4 security.
>>>
>>> What kernel version/gitref did you last test the 802.15.4 security
>>> on? What level of security are you using? (1-7)
>>>
>>> I can then have a look what has changed since and try and debug the
>>> problems I am seeing.
>>>
>>> I find if I set the security level to 1,2,3 I get a kernel panic
>>> whenever a packet is sent.
>>> If I set the security level to 4 the packets sent are corrupt.
>>> If I set the security level to 5-7 wireshark decodes the packets as
>>> MIC check failed.
>>>
>>> Regards
>>>
>>> Simon
>>>
>>> On 28/05/15 10:00, Phoebe Buckheister wrote:
>>>> Hi Simon,
>>>>
>>>> sorry for taking so long to reply. Unfortunately, there's
>>>> currently no actual documentation for the crypto layer (and I
>>>> probably won't come around to write any sometime soon), but I
>>>> have built an application that works with llsec [1].
>>>>
>>>> The process to set up a crypto config for a network is rougly
>>>> outlined in [2] and [3]. There are more options to the crypto
>>>> layer than are used there, but the process is pretty much the
>>>> same: you add a number of devices you want to securely
>>>> communicate with, add the keys those devices will use to
>>>> communicate, and then set the general parameters for llsec (like
>>>> default llsec, enabling the crypto layer and such).
>>>>
>>>> Hope that helps a little,
>>>> Phoebe
>>>>
>>>>
>>>> [1]
>>>> https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm
>>>> [2]
>>>> https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm/src/hxbnm.cpp#L160
>>>> [3]
>>>> https://github.com/mysmartgrid/hexabus/blob/pb-crypto/hostsoftware/hxbnm/src/hxbnm.cpp#L90
>>>>
>>>> On Thu, 21 May 2015 14:23:10 +0100
>>>> Simon Vincent <simon.vincent@xsilon.com> wrote:
>>>>
>>>>> What is the status of the crypto-layer? I can see a lot of crypto
>>>>> functionality in the mac layer but I can't work out how to setup
>>>>> the keys and enable encryption/authentication. Will this be part
>>>>> of the wpan-tools?
>>>>>
>>>>> - Simon
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>> linux-wpan" in the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at
>>>>> http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-wpan" in the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-wpan"
>> in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

