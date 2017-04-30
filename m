Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36323 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1950479AbdD3Ver (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 30 Apr 2017 17:34:47 -0400
Subject: Re: llsec: command failed: Operation not supported (-95)
References: <1492430559.14787.49.camel@boxhill.edu.au>
 <0d63c71c-d334-cd62-065e-b003a44bdced@pengutronix.de>
 <1493110673.3649.22.camel@boxhill.edu.au>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <8705449d-636f-bf0b-e6a0-1bf4e2d31daa@pengutronix.de>
Date: Sun, 30 Apr 2017 23:34:43 +0200
MIME-Version: 1.0
In-Reply-To: <1493110673.3649.22.camel@boxhill.edu.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jan Newmarch <j.newmarch@boxhill.edu.au>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On 04/25/2017 10:57 AM, Jan Newmarch wrote:
> Duh - didn't realise I had to rebuld the kernel too! I moved to the 4.9
> in the upstream RPi tree. I now set in .config
> 
>     CONFIG_IEEE802154=m
>     CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
>     CONFIG_IEEE802154_SOCKET=m
>     CONFIG_IEEE802154_6LOWPAN=m
>     CONFIG_MAC802154=m
>     CONFIG_NET_SCHED=y
> 
> But still getting an error (different one now)
> 
>     sudo ./iwpan  dev wpan0 set security 1
>     command failed: Invalid argument (-22)
> 
> Am I still missing a config option?
> 

no, it should work. Don't know why you get a -EINVAL do you set an
outkey, etc. Check linux-wpan wiki [0].

- Alex

[0] https://github.com/linux-wpan/wpan-tools/wiki/Guide:-Contiki-%E2%86%94-Linux,-with-llsec
