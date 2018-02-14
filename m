Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:35931 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031151AbeBNPZO (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 14 Feb 2018 10:25:14 -0500
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH 2/3] ieee802154: Add entry in MAINTAINTERS for MCR20a
 driver
References: <1517691074-20306-1-git-send-email-liuxuenetmail@gmail.com>
 <1517691074-20306-3-git-send-email-liuxuenetmail@gmail.com>
Message-ID: <a443b8c4-f676-6080-9a5e-5244b864f01c@osg.samsung.com>
Date: Wed, 14 Feb 2018 16:25:10 +0100
MIME-Version: 1.0
In-Reply-To: <1517691074-20306-3-git-send-email-liuxuenetmail@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hello.


On 02/03/2018 09:51 PM, Xue Liu wrote:
> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e262e23..275e389 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8555,6 +8555,14 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
>  F:	drivers/iio/potentiometer/mcp4531.c
>  
> +MCR20A IEEE-802.15.4 RADIO DRIVER
> +M:	Xue Liu <liuxuenetmail@gmail.com>
> +L:	linux-wpan@vger.kernel.org
> +W:	https://github.com/xueliu/mcr20a-linux
> +S:	Maintained
> +F:	drivers/net/ieee802154/mcr20a.c
> +F:	Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt

You are missing the header file from these file entries.

regards
Stefan Schmidt
