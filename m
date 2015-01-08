Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:62898 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305AbbAHTT2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Jan 2015 14:19:28 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
References: <1420720298-1995-1-git-send-email-alex.aring@gmail.com>
 <BD3A316F-B094-419D-B2EC-EF6D980A692A@holtmann.org>
In-reply-to: <BD3A316F-B094-419D-B2EC-EF6D980A692A@holtmann.org>
Subject: Re: [PATCHv4 bluetooth-next 0/3] 6lowpan: introduce nhc framework
Date: Thu, 08 Jan 2015 19:18:57 +0000
Message-id: <058601d02b77$f3f47050$dbdd50f0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: en-gb
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: 'Marcel Holtmann' <marcel@holtmann.org>, 'Alexander Aring' <alex.aring@gmail.com>
Cc: 'BlueZ development' <linux-bluetooth@vger.kernel.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de, 'Jukka Rissanen' <jukka.rissanen@linux.intel.com>, 'Martin Townsend' <mtownsend1973@gmail.com>

Hello.

On 08/01/15 20:06, Marcel Holtmann wrote:
> Hi Alex,
>
>> This patch series introduce the next header compression framework.
> Currently
>> we support udp compression/uncompression only. This framework allow to
> add new
>> next header compression formats easily.
>>
>> If somebody wants to add a new header compression format and some
> information
>> are missing while calling compression and uncompression callbacks.
> Please
>> feel free to make framework changes according these callbacks.
>>
>> changes since v2:
>> - make udp nhc as module as suggested by Marcel Holtmann
>> - fix comment header in nhc_udp.c
>>
>> I didn't make the lowpan_nhc declaration "const" because this will occur
>> issues with rb_node, id and idmask array. Which will manipulated during
>> runtime.
>>
>> changes since v3:
>> - add patch 3/3 for other known rfc6282 ipv6 extension headers
> compression
>>    formats
>> - add request_modules for loading nhc default compression format
> modules.
>>    Which was suggested by Jukka Rissanen. Thanks, this is really working.
>> - Add rtnl_lock for lowpan_nhc_add and del since we have no synced
>>    request_modules call this could make trouble.
>> - Move some handling out of nhc_do_compression and uncompression
> function.
>>    The complete handling is now inside of iphc.c and nhc_do_compression
> and
>>    uncompression functions is only a wrapper call for the callback.
>> - rework some menuentries for Kconfig and compression format, they are
>>    grouped by rfc now.
>> - move some generic handling like "skb_pull(skb, nhc->nexthdrlen);" into
>>    iphc.c. It would be great if we have something also for uncompression
>>    for the skb_cow. But this isn't possible right now.
>> - change warning if nhc was not found to "was not found" instead isn't
>>    implemented. It isn't implemented if callbacks are NULL now.
>> - small cleanups.
>>
>> changes since v4:
>> - add spinlock for to prevent nhc from deletion while using. This can
> occur
>>    if nhc module is unloading while compression/uncompression.
>> - move nhc handling for nhc compression/uncompression completely into
>>    nhc_do_compression/nhc_do_uncompression.
>>
>> Note about locking:
>>
>> We have now a spinlock nhc_lowpan_lock which prevents manipulating the
> nhc
>> datastructures while using it. On receiving side it's easy to handle, at
> the
>> end we check if 6lowpan nh compressed flag is set and run uncompression.
>> On the other hand the transmit side is complicated, we check if next_hdr
> field
>> is registrated and run some other compression routines, at least we do
> the
>> finally nhc compression which depends on the first check if next_hdr was
>> registrated. The kernel will crash if we remove the using module between
>> "next_hdr check" and "do nhc compression", the lock will prevent that
> now.
>>
>> Now in the transmit path exist a little window to remove a lowpan_nhc
> while
>> compression. This is exactly the part between "check if we support" and
>> "doing compression". This is a very unlikely case, if this occurs we
> drop
>> the packet while compression. Don't know how to better deal with that
> right
>> now. I will try to search a better solution later.
>>
>> Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>
>> Cc: Martin Townsend <mtownsend1973@gmail.com>
>> Cc: Marcel Holtmann <marcel@holtmann.org>
>>
>> Alexander Aring (3):
>>   6lowpan: add generic nhc layer interface
>>   6lowpan: add udp compression via nhc layer
>>   6lowpan: nhc: add other known rfc6282 compressions
>>
>> net/6lowpan/Kconfig             |  60 +++++++++-
>> net/6lowpan/Makefile            |  13 ++-
>> net/6lowpan/iphc.c              | 200 ++++++---------------------------
>> net/6lowpan/nhc.c               | 241
> ++++++++++++++++++++++++++++++++++++++++
>> net/6lowpan/nhc.h               | 146 ++++++++++++++++++++++++
>> net/6lowpan/nhc_rfc6282_dest.c  |  27 +++++
>> net/6lowpan/nhc_rfc6282_frag.c  |  26 +++++
>> net/6lowpan/nhc_rfc6282_hop.c   |  26 +++++
>> net/6lowpan/nhc_rfc6282_ipv6.c  |  26 +++++
>> net/6lowpan/nhc_rfc6282_mobil.c |  26 +++++
>> net/6lowpan/nhc_rfc6282_route.c |  26 +++++
>> net/6lowpan/nhc_rfc6282_udp.c   | 156 ++++++++++++++++++++++++++
>
> can we please remove the _rfc6282 from the filenames. RFCs get update and
> thus change numbers. I do not want to carry RFC numbers in filenames
> around. There is also almost no precedence in the kernel source code that
> would justify doing this.

They look indeed quite ugly in the filename. :)

Moving them as a comment and starting point into the file should be 
enough. Maybe we can also rename nhc_mobil to nhc_mobility. The other 
abbreviations are clear in my opinion but for mobil I actually opened 
the rfc to look what you mean here.

regards
Stefan Schmidt


