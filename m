Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35325 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbbELDsY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 11 May 2015 23:48:24 -0400
Received: by pabtp1 with SMTP id tp1so129340423pab.2
        for <linux-wpan@vger.kernel.org>; Mon, 11 May 2015 20:48:24 -0700 (PDT)
Message-ID: <555177F2.7060502@gmail.com>
Date: Tue, 12 May 2015 09:18:02 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: cc2520 issue
References: <CAOoq=dTEMhzkjRYhkoz1H_F4FGg1eYGKis-LZR0p5LX-2-ZMYA@mail.gmail.com> <5551768F.1000206@gmail.com>
In-Reply-To: <5551768F.1000206@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Karol Poczesny <kpoczesny@gmail.com>, linux-wpan@vger.kernel.org

On 05/12/2015 09:12 AM, Varka Bhadram wrote:
> Hi Karol Poczesny,
>
> On 05/12/2015 03:24 AM, Karol Poczesny wrote:
>
>> Hello all,
>>
>> I have tested simple ping communication between two devices:
>> 1.) Raspberry Pi with at86rf233 transceiver - (openlab module)
>> and
>> 2.) Raspberry Pi with CC2520 transceiver - my own radio board.
> I used BeagleBoneBlack with cc2520. It worked for me. Able to communicate
> with TinyOS nodes.
>
>> I am able to run the interface and start transmit frames for both nodes,
>> but only node with at86rf233 respond.
>>
>> Node with CC2520 can send e.g ping message but cannot answer for ping from
>> at86rf233 node and ignore any other requests.
>>
>> I had checked my radio board - I complied my system with debug in cc2520.c
>> and received this:
>>
>> ...
>> [ 661.896458] cc2520 spi32766.0: SFD for RX
>> [ 937.179079] cc2520 spi32766.0: SFD for RX
> It will just a debug message that will indicate a packet has received. After a packet
> has received cc2520 will generate SFD interrupt. 
>
>> so - I received SFD interrupt for RX this function is processed and it
>> seems that received packet stuck somewhere on Rx path.
> Can you please enable the debug for mac802154 and see whether the packet is going
> to the upper layers or not..?
>
>> I'm going to track this anomaly but maybe someone had similar problem.
>> Maybe there are some issues related with configuration cc2520 + RPi?
>> Somebody tested this configuration ?
>>
>> I use pretty old kernel version (3.17.0-rc1+) and old userspace tool - iz
>> on both sides. Configuration is this same as on openlab web.
> Use the latest bluetooth-next [0] tree. And this iz tools are now deprecated
> with the new kernel versions. Use the iwpan [1] tools (similar to iw for wireless). 

iwpan/wpan-tools

[0]: git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
[1]: https://github.com/linux-wpan/wpan-tools

>> Solution is described on my blog:
>> [0] http://zanaster.blogspot.com/2015/05/rpi-6lowpan-solution-with-cc2520.html
> Nice. 
>
>> Best,
>> Karol
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Thanks,
>


-- 
Varka Bhadram

