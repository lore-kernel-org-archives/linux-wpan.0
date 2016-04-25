Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36517 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbcDYHmJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 25 Apr 2016 03:42:09 -0400
Received: by mail-wm0-f48.google.com with SMTP id v188so86892328wme.1
        for <linux-wpan@vger.kernel.org>; Mon, 25 Apr 2016 00:42:08 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/9] libnl: nla_put_le64(): align on a 64-bit
 area
References: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
 <1461339084-3849-3-git-send-email-nicolas.dichtel@6wind.com>
 <1461343880.7627.34.camel@edumazet-glaptop3.roam.corp.google.com>
 <60b94d1a-23a2-ec18-7f2b-2ba21946af03@pengutronix.de>
 <9d534571-916d-b368-a398-7f03a1f512ec@pengutronix.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <571DCA3F.3040403@6wind.com>
Date: Mon, 25 Apr 2016 09:41:51 +0200
MIME-Version: 1.0
In-Reply-To: <9d534571-916d-b368-a398-7f03a1f512ec@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, bsingharora@gmail.com

Le 23/04/2016 19:28, Alexander Aring a écrit :
>
> Hi,
>
> On 04/23/2016 07:05 PM, Alexander Aring wrote:
> ...
>>
>> if this is really needed, then nla_put_u64/be64/etc need to be changed also,
>
> Okay, I found PATCH 3/9 do it for be64, but what's about u64?
It's also planned. I will send several "small" series to ease integration.


Regards,
Nicolas
