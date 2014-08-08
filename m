Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:43289 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755618AbaHHJ4S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Aug 2014 05:56:18 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa1so7100024pad.27
        for <linux-wpan@vger.kernel.org>; Fri, 08 Aug 2014 02:56:18 -0700 (PDT)
Message-ID: <53E49E62.3010908@gmail.com>
Date: Fri, 08 Aug 2014 15:24:42 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
References: <53E48D10.3090606@gmail.com> <20140808093353.GC20055@omega>
In-Reply-To: <20140808093353.GC20055@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: Regarding dev->addr_len
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

On 08/08/2014 03:03 PM, Alexander Aring wrote:
> Hi Varka,
>
> On Fri, Aug 08, 2014 at 02:10:48PM +0530, Varka Bhadram wrote:
>> Hi Alex,
>>
>> I need some clarification regarding address length for the netdevice.
>> We are always setting up that to IEEE802154_ADDR_LEN [1].
>>
>> If i receive a packet (RS: Router Solicitation) with short addressing mode,
>> it is discarding at higher layers.
>>
>> If the linux node receives the RS packet from TinyOS node its discarding
>> at [2] due to address length field. Here [2] we are getting *lladdr* as NULL.
>>
> yes, I said about some months ago to Martin that he should not use short
> addresses in 6lowpan because it's simply not working currently.
>
>> Actually we have to update the dev->addr_len filed as per the packet info it received ..?
>>
> If you look at net/ipv6/ndisc.c code you will notice that when you
> change the addr_len of netdevice during runtime will end in an
> unexecpted behaviour.
>
>> How can we make it work..?
>>
> I already open a thread to related this question [0]. Please don't open a
> new one! David wrote something I need to answer him, but need to
> consider how I can describe the current behaviour in words.
>
> We can't just do own changes in net/ipv6/ndisc.c, only very very small
> changes and changes which don't brake the ethernet, etc... neighbor
> discovery. I have several ideas to deal with, some need a complete
> change of architecture to deal with short and extended addresses.
>
> Currently we have in dev_addr the extended address and the addr_len is a
> static value. And that's also what the neighbor discovery use from L2,
> the addr_len and dev_addr only.
>
> Okay, there are also the header_ops callbacks, I need to take a closer
> look into that to have some idea.
>
> - Alex
>
> [0] http://www.spinics.net/lists/netdev/msg291767.html

Entire Network layer may be working with 48-bit or 64-bit MAC address only.

May be we need to change this behavior to work with 16-bit also ...?

Also for a interface we are going to have one netdevice structure ...?

If yes, dynamically updating dev_addr and addr_len creates problems..?

-- 
Regards,
Varka Bhadram.

