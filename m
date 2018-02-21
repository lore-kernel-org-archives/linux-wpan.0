Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:33922 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbeBUJt4 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 21 Feb 2018 04:49:56 -0500
Subject: Re: [PATCHv3 2/3] ieee802154: Add entry in MAINTAINTERS for MCR20a
 driver
References: <1519127758-2084-1-git-send-email-liuxuenetmail@gmail.com>
 <1519127758-2084-3-git-send-email-liuxuenetmail@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <d41f05a2-0fdf-773b-f58a-8b115a43fba0@osg.samsung.com>
Date: Wed, 21 Feb 2018 10:49:52 +0100
MIME-Version: 1.0
In-Reply-To: <1519127758-2084-3-git-send-email-liuxuenetmail@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hello.


On 02/20/2018 12:55 PM, Xue Liu wrote:
> Signed-off-by: Xue Liu <liuxuenetmail@gmail.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e262e23..497efe4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8555,6 +8555,15 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
>  F:	drivers/iio/potentiometer/mcp4531.c
>  
> +MCR20A IEEE-802.15.4 RADIO DRIVER
> +M:	Xue Liu <liuxuenetmail@gmail.com>
> +L:	linux-wpan@vger.kernel.org
> +W:	https://github.com/xueliu/mcr20a-linux
> +S:	Maintained
> +F:	drivers/net/ieee802154/mcr20a.c
> +F:	drivers/net/ieee802154/mcr20a.h
> +F:	Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
> +
>  MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
>  M:	William Breathitt Gray <vilhelm.gray@gmail.com>
>  L:	linux-iio@vger.kernel.org
This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
