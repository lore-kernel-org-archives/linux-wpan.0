Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:32541 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757115AbbAING6 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 9 Jan 2015 08:06:58 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1420720298-1995-1-git-send-email-alex.aring@gmail.com>
 <BD3A316F-B094-419D-B2EC-EF6D980A692A@holtmann.org>
 <058601d02b77$f3f47050$dbdd50f0$@samsung.com> <20150108200443.GB2046@omega>
 <20150108200821.GC2046@omega>
In-reply-to: <20150108200821.GC2046@omega>
Subject: Re: [PATCHv4 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Date: Fri, 09 Jan 2015 13:06:51 +0000
Message-id: <05f101d02c0d$227c8fd0$6775af70$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=utf-8
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Alexander Aring' <alex.aring@gmail.com>
Cc: 'Marcel Holtmann' <marcel@holtmann.org>, 'BlueZ development' <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, 'Jukka Rissanen' <jukka.rissanen@linux.intel.com>, 'Martin Townsend' <mtownsend1973@gmail.com>

Hello.

On 08/01/15 21:08, Alexander Aring wrote:
> On Thu, Jan 08, 2015 at 09:04:43PM +0100, Alexander Aring wrote:
>> Hi,
>>
>> On Thu, Jan 08, 2015 at 07:18:57PM +0000, Stefan Schmidt wrote:
>> ...
>>>>> net/6lowpan/nhc.h               | 146 ++++++++++++++++++++++++
>>>>> net/6lowpan/nhc_rfc6282_dest.c  |  27 +++++
>>>>> net/6lowpan/nhc_rfc6282_frag.c  |  26 +++++
>>>>> net/6lowpan/nhc_rfc6282_hop.c   |  26 +++++
>>>>> net/6lowpan/nhc_rfc6282_ipv6.c  |  26 +++++
>>>>> net/6lowpan/nhc_rfc6282_mobil.c |  26 +++++
>>>>> net/6lowpan/nhc_rfc6282_route.c |  26 +++++
>>>>> net/6lowpan/nhc_rfc6282_udp.c   | 156 ++++++++++++++++++++++++++
>>>>
>>>> can we please remove the _rfc6282 from the filenames. RFCs get update
>>>> and
>>>> thus change numbers. I do not want to carry RFC numbers in filenames
>>>> around. There is also almost no precedence in the kernel source code
>>>> that
>>>> would justify doing this.
>>>
>>> They look indeed quite ugly in the filename. :)
>>>
>>> Moving them as a comment and starting point into the file should be
>>> enough.
>>> Maybe we can also rename nhc_mobil to nhc_mobility. The other
>>> abbreviations
>>> are clear in my opinion but for mobil I actually opened the rfc to look
>>> what
>>> you mean here.
>>>
>>
>> For the rfc6282 thing:
>>
>> Currently there exists two RFCs which describes an UDP compression. It's
>> rfc6282 (the well known 6LoWPAN IPHC compression RFC) and RFC7400 which
>> was pointed out by Martin Townsend [0].
>>
>> We need to clarify how we should deal with multiple definitions for a
>> compression format. On receiving side we should always support what we
>> can which is decided by the variable nhcid length. While on transmit...
>> we need still some configuration interface (my dreams are to decide the
>> compression methods per socket, don't know how possible that is).
>>
>> For the handling I thought that we have then two UDP nhc modules, both
>> can be loaded (at the moment _only_ one UDP nhc compressression should
>> implement the compress methods, both should implement uncompression
>> methods).
>>
>> I can rename it to nhc_udp.c for the standard compression methods
>> according to rfc6282, I am fine with that. But later there exists then
>> an another compression module with the naming "nhc_ghc_udp.c" or
>> something else. So we have "nhc_udp.ko" and "nhc_ghc_udp.ko".
>> Is that okay for everybody?
>>
>
> We can also put all udp compression formats into the nhc_udp.c file. But
> then all udp compressions are handled by one module then. We should not
> do that, because we can handle it per module.

I would keep them all in different modules for now.

regards
Stefan Schmidt


