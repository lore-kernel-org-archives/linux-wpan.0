Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56806 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaJBJgF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Oct 2014 05:36:05 -0400
Message-ID: <542D1C80.9050807@xsilon.com>
Date: Thu, 02 Oct 2014 10:36:00 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH linux-wpan 0/3] Fix handling of skbs of type PACKET_OTHERHOST
References: <1412240206-6098-1-git-send-email-simon.vincent@xsilon.com> <20141002092804.GC3850@omega>
In-Reply-To: <20141002092804.GC3850@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, varkabhadram@gmail.com, jukka.rissanen@linux.intel.com

I will add this patch when I rebase on bluetooth-next.

On 02/10/14 10:28, Alexander Aring wrote:
> On Thu, Oct 02, 2014 at 09:56:43AM +0100, Simon Vincent wrote:
>> This series of patches fix the cases where the pkt_type is overriden
>> resulting in skbs of type PACKET_OTHERHOST getting set to PACKET_HOST.
>> Also it drops packets of PACKET_OTHERHOST type in the 6lowpan layer
>> as there is not point processing them as they are dropped at the next
>> layer.
> Please don't forget:
>
> $ grep -r -n "PACKET_HOST" net/bluetooth/6lowpan.c
>
> 276:		local_skb->pkt_type = PACKET_HOST;
>
> - Alex

