Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:47404 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756018AbaJ2Ico (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 29 Oct 2014 04:32:44 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so2521633pde.36
        for <linux-wpan@vger.kernel.org>; Wed, 29 Oct 2014 01:32:43 -0700 (PDT)
Message-ID: <5450A57C.1070004@gmail.com>
Date: Wed, 29 Oct 2014 13:59:48 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] MAINTAINERS: add cc2520 driver maintainer
References: <1414571196-9407-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1414571196-9407-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "varkab@cdac.in" <varkab@cdac.in>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

On 10/29/2014 01:56 PM, Varka Bhadram wrote:
> This patch adds maintainer from cc2520 radio driver.

from/for

I will send updated patch..

> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>   MAINTAINERS |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 15867a6..43dc166 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4698,6 +4698,14 @@ F:	include/net/cfg802154.h
>   F:	include/net/ieee802154_netdev.h
>   F:	Documentation/networking/ieee802154.txt
>   
> +CC2520 IEEE-802.15.4 RADIO DRIVER
> +M:	Varka Bhadram <varkabhadram@gmail.com>
> +L:	linux-wpan@vger.kernel.org
> +S:	Maintained
> +F:	drivers/net/ieee802154/cc2520.c
> +F:	include/linux/spi/cc2520.h
> +F:	Documentation/devicetree/bindings/net/ieee802154/cc2520.txt
> +
>   IGUANAWORKS USB IR TRANSCEIVER
>   M:	Sean Young <sean@mess.org>
>   L:	linux-media@vger.kernel.org
>
> -- 
> Regards,
> Varka Bhadram.
