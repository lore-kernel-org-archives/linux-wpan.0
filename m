Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44160 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfATS4V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 20 Jan 2019 13:56:21 -0500
Subject: Re: [RFC net-next] net: Z-Wave driver prototype
References: <20190120183315.22743-1-afaerber@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5f5aa12c-604d-ca10-1873-f5f2bbe3d266@infradead.org>
Date: Sun, 20 Jan 2019 10:56:07 -0800
MIME-Version: 1.0
In-Reply-To: <20190120183315.22743-1-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, TL Lim <tllim@pine64.org>, "David S. Miller" <davem@davemloft.net>

On 1/20/19 10:33 AM, Andreas Färber wrote:
> diff --git a/drivers/net/zwave/Makefile b/drivers/net/zwave/Makefile
> new file mode 100644
> index 000000000000..1a4171308c79
> --- /dev/null
> +++ b/drivers/net/zwave/Makefile
> @@ -0,0 +1 @@
> +obj-m += zwave.o


Hi,

This will need a Kconfig file and a symbol so that the Makefile
will not always build the zwave module.

thanks,
-- 
~Randy
