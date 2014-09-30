Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42120 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbaI3ItO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Sep 2014 04:49:14 -0400
Received: by mail-pd0-f182.google.com with SMTP id y10so7026959pdj.27
        for <linux-wpan@vger.kernel.org>; Tue, 30 Sep 2014 01:49:13 -0700 (PDT)
Message-ID: <542A6DF6.809@gmail.com>
Date: Tue, 30 Sep 2014 14:16:46 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: ICMPv6 Redirects
References: <54295556.3030800@xsilon.com> <20140929131200.GA14608@omega> <20140929133048.GB14608@omega> <54295FA9.8030506@xsilon.com> <20140929133841.GA15176@omega> <542963F7.4030903@xsilon.com> <20140929135759.GA15411@omega> <542968C5.7000505@xsilon.com> <20140929164157.GA17633@omega> <542A6B15.7060203@xsilon.com> <20140930083835.GA20280@omega>
In-Reply-To: <20140930083835.GA20280@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Alex,

On 09/30/2014 02:09 PM, Alexander Aring wrote:
> On Tue, Sep 30, 2014 at 09:34:29AM +0100, Simon Vincent wrote:
>> I can confirm that this fixes the problem. I will create some patches when I
>> get a chance.
>> Thanks
>>
> This should make trouble on phy's which have no address filter...

I didnt get what do you mean by this..?

> But when IPv6 Layer look on PACKET_BROADCAST then this is also another
> bug...
>
> I did a grep:
>
> grep -r "PACKET_BROADCAST" net/IPv6
>
> matches on:
>
> net/ipv6/mcast.c:	    skb->pkt_type != PACKET_BROADCAST)

This match for IGMPv6...

> whatever this is, it's also fixed by this. Because we override always
> this value with PACKET_HOST.

-- 
Regards,
Varka Bhadram.

