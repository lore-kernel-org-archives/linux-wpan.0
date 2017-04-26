Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:55840
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1960121AbdDZJPQ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 26 Apr 2017 05:15:16 -0400
Subject: Re: Applications on wpan-linux
References: <CAJuUDws4t0mSS4mONnXs=b9QLF28w9CTfQE-+2QKMnHg8_5HmA@mail.gmail.com>
 <b3e88cdb-59f7-5915-6abe-36c5b6cfc8ef@osg.samsung.com>
 <CAJuUDwuos=Zy+_8i=Kz86GXXpXVS=7t9UjvJsNkVS_A3ZQ2yOg@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <d72082c7-5032-d9e2-3939-af75cc0857b7@osg.samsung.com>
Date: Wed, 26 Apr 2017 11:15:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAJuUDwuos=Zy+_8i=Kz86GXXpXVS=7t9UjvJsNkVS_A3ZQ2yOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 04/26/2017 11:05 AM, Xue Liu wrote:
>
>
> On 25 April 2017 at 16:10, Stefan Schmidt <stefan@osg.samsung.com
> <mailto:stefan@osg.samsung.com>> wrote:
>> Hello.
>>
>> On 04/25/2017 12:00 PM, Xue Liu wrote:
>>>
>>> Hello,
>>>
>>> I am working on 802.15.4 integration into OpenWRT/LEDE system. In
>>> OpenWRT/LEDE man can build 802.11 wireless network with hostapd,
>>> wpa_supplicant, netifd and LuCI interface, which I would like also to
>>> do with 802.15.4. Thus I did similar things like iwpaninfo and adding
>>> 802.15.4 support to netifd. With these man can config 802.15.4
>>> interfaces. Now I am looking for applications to build a 802.15.4
>>> network like hostapd and wpa_supplicant. Can you give me some advises
>>> ?
>>
>>
>> If I understand this correctly you want to send out beacons to announce a
>> 15.4 network and do basic PAN coordinator tasks like handing out short
>> addresses and keeping track of devices within the PAN. Is that correct?
>>
>
> Correct.
>
>> We do not have this functionality right now. All communication is
> ad-hoc and
>> based knowing network parameters like channel, etc.
>>
>> Various steps are needed to get to the functionality you are looking
> for. 1)
>> Add support for MAC command frames for network management, 2) add support
>> for beacon frames 3) expose a netlink UAPI to act as a PAN coordinator and
>> 4) a coordinator daemon in userspace.
>>
>
> That sounds complicated. 🤔

It is a big bunch of work indeed.

With your work on various drivers you might have your hands full already. :)

Some more information about this can be found at our todo list SoftMAC 
section and the linked github issues.
https://github.com/linux-wpan/wpan-tools/wiki/todo

regards
Stefan Schmidt
