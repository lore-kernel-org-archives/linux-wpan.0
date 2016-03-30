Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:59309 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbcC3Umg (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 16:42:36 -0400
Subject: Re: No device found for binding socket ieee802.15.4
References: <CALqexQVqxwfKxZ=fmtjQPnHcdibVFmFTG4dRZkBwC4aJfLkE5A@mail.gmail.com>
 <20160329083732.GA1114@omega>
 <CALqexQUhA-wTJow59_PkkbnmJz8UWxW2WoCdU=qYHYNQjyMVvQ@mail.gmail.com>
 <56FB8E7F.70106@osg.samsung.com>
 <CALqexQWw4QuPWxTDe8SdHxeOptq6TCf-O4Mq_UL-pDxqUz=h1A@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <56FC3A38.7030305@osg.samsung.com>
Date: Wed, 30 Mar 2016 22:42:32 +0200
MIME-Version: 1.0
In-Reply-To: <CALqexQWw4QuPWxTDe8SdHxeOptq6TCf-O4Mq_UL-pDxqUz=h1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Adika Bintang Sulaeman <adikabintang78@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Hello.

On 30/03/16 21:21, Adika Bintang Sulaeman wrote:
>> On 3/30/16, Stefan Schmidt <stefan@osg.samsung.com> wrote:
>> Are you actually sure you have the socket code for ieee802154 enabled in
>> your kernel build?
>> CONFIG_IEEE802154_SOCKET
>>
>> If it is not build into the kernel, are you sure the module is loaded?
>>
>> regards
>> Stefan Schmidt
>>
> Hi Stefan,
>
> Fortunately I got 802.15.4 socket work by modifying wpan-ping code.

I still don't see why you would need to do this. What did you change?

>   By
> the way, does the function generate_packet(unsigned char *buf, struct
> config *conf, unsigned int seq_num) try to generate a packet which is
> not 6LoWPAN? The code set 0x00 for the dispatch header.

Yes, it is a 802.15.4 ping utility not using 6lowpan at all. Thus the 
dispatch header is set to not a 6lowpan frame to avoid problems.

> Now I need an
> example of using 6LoWPAN socket API instead of creating packet
> manually. Would anyone mind sharing the code if you have implement it?

Its the normal IPv6 socket API of linux.

regards
Stefan Schmidt
