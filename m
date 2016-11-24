Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:54824
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756652AbcKXOcO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Nov 2016 09:32:14 -0500
Subject: Re: [PATCH] net: ieee802154: drop duplicate header delay.h
References: <15299de49216a2360976ca37ff774cae9d27d88b.1479991297.git.geliangtang@gmail.com>
 <f64943b9c1da12b6199ba745ba04cb477a05a5a3.1479991128.git.geliangtang@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <bf9ffb55-9b75-735d-063d-b04c7c197a60@osg.samsung.com>
Date: Thu, 24 Nov 2016 15:32:02 +0100
MIME-Version: 1.0
In-Reply-To: <f64943b9c1da12b6199ba745ba04cb477a05a5a3.1479991128.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Geliang Tang <geliangtang@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 24/11/16 14:58, Geliang Tang wrote:
> Drop duplicate header delay.h from adf7242.c.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  drivers/net/ieee802154/adf7242.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index 4ff4c7d..3e4c8b2 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -20,7 +20,6 @@
>  #include <linux/skbuff.h>
>  #include <linux/of.h>
>  #include <linux/irq.h>
> -#include <linux/delay.h>
>  #include <linux/debugfs.h>
>  #include <linux/bitops.h>
>  #include <linux/ieee802154.h>
>

Good catch.

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt
