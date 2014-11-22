Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:52310 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbaKVAZk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Nov 2014 19:25:40 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so6288522pdb.29
        for <linux-wpan@vger.kernel.org>; Fri, 21 Nov 2014 16:25:40 -0800 (PST)
Message-ID: <546FD7F5.1060901@gmail.com>
Date: Sat, 22 Nov 2014 05:55:25 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: Unused function mac802154_header_parse()
References: <546F62C1.6010500@gmail.com> <20141121171055.GE20364@omega>
In-Reply-To: <20141121171055.GE20364@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

On Friday 21 November 2014 10:40 PM, Alexander Aring wrote:
> On Fri, Nov 21, 2014 at 09:35:21PM +0530, Varka Bhadram wrote:
>> Hi,
>>
>> There are two header_ops operations defined for mac802154 at [1]. One is for creating header another for parsing.
>>
>> Creation of mac802154_header_create() happening at [2] by using dev_hard_header(), but i did not find dev_parse_header()
>> for header parse by mac802154_header_parse().
>>
>> Am i missing anything.?
>>
> For the dev_parse_header usage:
>
> `grep -r -n "dev_parse_header" net`:
>
> net/packet/af_packet.c:1823:	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
> net/packet/af_packet.c:2030:	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
>
> This is used by the packet layer at several places.
>
>
>
> I need to dig more into this. It seems that these callback structure are
> optional because dev_hard_header and dev_parse_header header return 0 if
> they are not implemented.
>
> Also it seems that when af_packet uses dev_hard_header header it could
> be that the control block information is overwritten by packet_skb_cb.
> So it's _maybe_ a bug to add additional parameters over control block
> information for the header_create callback.

My point is that no where mac802154_header_parse() function is called.

This has to be called by dev_parse header().

-- 
Thanks and Regards,
Varka Bhadram.

