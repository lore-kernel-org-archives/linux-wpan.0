Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from exprod7og119.obsmtp.com ([64.18.2.16]:39254 "HELO
	exprod7og119.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753985AbaHFAqQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Aug 2014 20:46:16 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so2246291pdj.22
        for <linux-wpan@vger.kernel.org>; Tue, 05 Aug 2014 17:46:16 -0700 (PDT)
Message-ID: <53E1797C.8000207@miraclelinux.com>
Date: Wed, 06 Aug 2014 09:40:28 +0900
From: =?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kv5ZCJ6Jek6Iux5piO?=
	<hideaki.yoshifuji@miraclelinux.com>
MIME-Version: 1.0
References: <20140805121516.GB14196@omega>
In-Reply-To: <20140805121516.GB14196@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: IPv6 over IEEE 802.15.4 aka 6LoWPAN - Neighbor discovery issue
To: Alexander Aring <alex.aring@gmail.com>, davem@davemloft.net
Cc: hideaki.yoshifuji@miraclelinux.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@trash.net, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

Hi,

Alexander Aring wrote:
> There exist no mapping between extended and short addresses. The global problem
> that the neighbor discovery cache handle the address length with a static addr_len
> value from net_device, this value should not be changed during runtime.
>
>
> To handle 6LoWPAN over IEEE 802.15.4 correctly we need to indicate that the neighbor
> discovery stores an extended or short address.
:
> My idea:
>
> Let addr_len to extended_address_length + 1. In the last byte we have a bit which
> indicate that is it a short address. If this bit isn't set we have an extended
> address.
>
> If we do that, we need some conversions about generating the ICMPv6 messages according
> to [1]. We can solve that with some hooks in net/ipv6/ndisc.c like the ndisc_mc_map
> function for mapping mac multicast addresses.
>
> Another idea to avoid hooks in net/ipv6/ndisc.c  is to parse and rebuild the ICMPv6
> header while replacing IPv6 with the 6LoWPAN header.

Please avoid magling icmpv6/ipv6 bits as much as possible.

> Please I need help and I need a solution which is also acceptable for mainline.

We can have L2-specific private data per NCE, and 6lowpan uses ARPHRD_IEEE802154.
Please consider using it for L2 private data, if you need L2-speicic extra
information per NCE.

Regards,

--yoshfuji
