Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32950 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbaI2OI2 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 10:08:28 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so3339750pdj.12
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 07:08:28 -0700 (PDT)
Message-ID: <54296711.8060006@gmail.com>
Date: Mon, 29 Sep 2014 19:35:05 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <54293B6C.7040800@gmail.com> <54293DD4.1090907@xsilon.com> <5429441C.5000302@gmail.com> <5429466F.4080506@gmail.com> <54295556.3030800@xsilon.com> <20140929131200.GA14608@omega> <20140929133048.GB14608@omega> <54295FA9.8030506@xsilon.com> <20140929133841.GA15176@omega> <542963F7.4030903@xsilon.com> <20140929135759.GA15411@omega>
In-Reply-To: <20140929135759.GA15411@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Monday 29 September 2014 07:28 PM, Alexander Aring wrote:
> On Mon, Sep 29, 2014 at 02:51:51PM +0100, Simon Vincent wrote:
>> Sorry for the confusion. My problem is I am receiving all packets.
>> PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka was to
>> disable redirects however it now seems that this is not possible on a ipv6
>> interface.
>>
>> I can fix the problem by dropping PACKET_OTHERHOST in mac802154_subif_frame.
> The first what IPv6 does is [0].
>
> See my previous mail. Also that we should handle on 6LoWPAN packet
> handler function for receiving "lowpan_rcv" we should do the same,
> otherwise we parsing PACKET_OTHERHOST sk_buff's and drop these directly
> in IPv6 layer, which makes no sense.
>
> But what I see is that the current behaviour should also work.
> Instrument the IPv6 delivery function and be sure that the information
> about PACKET_OTHERHOST was not dropped.
>
> - Alex
>
> [0] http://lxr.free-electrons.com/source/net/ipv6/ip6_input.c#L72

Generally Echo reply will happen at the IP Layer. But the dropping of packet is
happening at IPv6 layer by as you mentioned above.

 From where the packet redirected we need to debug the  exact reason...?

-- 
-Varka Bhadram

