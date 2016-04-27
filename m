Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38223 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbcD0Pqs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2016 11:46:48 -0400
Received: by mail-wm0-f50.google.com with SMTP id u206so55757711wme.1
        for <linux-wpan@vger.kernel.org>; Wed, 27 Apr 2016 08:46:47 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 9/9] taskstats: use the libnl API to align nlattr
 on 64-bit
References: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
 <1461339084-3849-10-git-send-email-nicolas.dichtel@6wind.com>
 <57201287.80002@gmail.com> <57206A47.2010906@6wind.com>
 <5720B0A2.1030405@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <5720DED8.4090706@6wind.com>
Date: Wed, 27 Apr 2016 17:46:32 +0200
MIME-Version: 1.0
In-Reply-To: <5720B0A2.1030405@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balbir Singh <bsingharora@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au

Le 27/04/2016 14:29, Balbir Singh a écrit :
[snip]
> Please try
> 
> https://www.kernel.org/doc/Documentation/accounting/getdelays.c
A patch follows this mail to fix that.

> 
> iotop uses it as well. My concern is ABI breakage of user space.
My test is ok here, I didn't see a problem.
Code review (from here http://repo.or.cz/w/iotop.git) is also ok.


Regards,
Nicolas
