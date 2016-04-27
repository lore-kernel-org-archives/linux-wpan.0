Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35546 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcD0M3g (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2016 08:29:36 -0400
Subject: Re: [PATCH net-next 9/9] taskstats: use the libnl API to align nlattr
 on 64-bit
References: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
 <1461339084-3849-10-git-send-email-nicolas.dichtel@6wind.com>
 <57201287.80002@gmail.com> <57206A47.2010906@6wind.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5720B0A2.1030405@gmail.com>
Date: Wed, 27 Apr 2016 22:29:22 +1000
MIME-Version: 1.0
In-Reply-To: <57206A47.2010906@6wind.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: nicolas.dichtel@6wind.com, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au



On 27/04/16 17:29, Nicolas Dichtel wrote:
> Le 27/04/2016 03:14, Balbir Singh a écrit :
>>
>>
>> On 23/04/16 01:31, Nicolas Dichtel wrote:
>>> Goal of this patch is to use the new libnl API to align netlink attribute
>>> when needed.
>>> The layout of the netlink message will be a bit different after the patch,
>>> because the padattr (TASKSTATS_TYPE_STATS) will be inside the nested
>>> attribute instead of before it.
>>>
>>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>
>> The layout will change/break user space -- I've not tested the patch though..
> Sigh.
> 
> I quote David:
> "All userspace components using netlink should always ignore attributes
> they do not recognize in dumps.
> 
> This is one of the most basic principles of netlink"
> 
> Do you have some pointers so I can made some tests?
> 

Please try

https://www.kernel.org/doc/Documentation/accounting/getdelays.c

iotop uses it as well. My concern is ABI breakage of user space.

Balbir Singh
