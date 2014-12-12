Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:9816 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbaLLIys convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Dec 2014 03:54:48 -0500
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NGG0084OOY5HF30@mailout2.w1.samsung.com> for
 linux-wpan@vger.kernel.org; Fri, 12 Dec 2014 08:58:53 +0000 (GMT)
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <20141207150814.GA9532@omega> <548487CF.4060009@fid4.com>
 <20141207171311.GB9532@omega> <20141207171903.GC9532@omega>
 <5484C900.2020402@fid4.com> <20141207215452.GB20260@omega>
 <5489B215.20707@fid4.com>
In-reply-to: <5489B215.20707@fid4.com>
Subject: Re: [ANNOUNCE] wpan-tools 0.3 released
Date: Fri, 12 Dec 2014 08:54:43 +0000
Message-id: <243b01d015e9$45bfdef0$d13f9cd0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=UTF-8
Content-transfer-encoding: 8BIT
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "'Michael C. Cambria'" <mcc@fid4.com>, 'Alexander Aring' <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 11/12/14 16:02, Michael C. Cambria wrote:
>
> On 12/07/2014 04:54 PM, Alexander Aring wrote:
>>
>> ok. Read introductions at [0]. Begin at "Bring up 6LoWPAN" section.
>> For the at86rf230 you should have default a wpan0 interface. If you
>> use wpan-tools simple type "iwpan" and read the help for setting
>> address information. I think for at86rf230 you need to set the panid
>> only, phy settings should be transceiver defaults and short address
>> isn't supported for 6LoWPAN (except broadcast address, of course). The
>> documentation is a little bit outdated currently.
> [deleted]
>>
>> If you need help simple ask here or for better fast live supporting
>> you can contact me via IRC #linux-wpan on irc.freenode.net. Ping
>> between two nodes should be an easy setup. - Alex [0]
>> http://linux-zigbee.sourceforge.net/cgi-bin/trac.cgi/wiki/GettingStarted-0.2
>>
>> -- To unsubscribe from this list: send the line "unsubscribe
>> linux-wpan" in the body of a message to majordomo@vger.kernel.org More
>> majordomo info at http://vger.kernel.org/majordomo-info.html
>
> I'm using bluetooth-next, and it boots and seems to find the openlabs.co
> adapter just fine.

Thanks for mentioning this adapter. I was looking for something like 
this for a while. Just ordered. :)

Anyone has some tips about cheap but easy to use sensor nodes with 
contiki and maybe TinyOS support? I don't care about senors or such on 
them at all. My use case would be testing the communication interop 
between the Linux stack and contiki or other embedded OS's.

All I found so far are 70€ or higher which I find a bit pricey for my 
use case.

regards
Stefan Schmidt


