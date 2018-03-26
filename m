Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:52676 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbeCZQIZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 26 Mar 2018 12:08:25 -0400
Date: Mon, 26 Mar 2018 12:08:20 -0400 (EDT)
Message-Id: <20180326.120820.1903008086350362171.davem@davemloft.net>
Subject: Re: [PATCH 4/4] drivers/net: Use octal not symbolic permissions
From: David Miller <davem@davemloft.net>
In-Reply-To: <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
References: <cover.1521845235.git.joe@perches.com>
        <8f24a711e6b8ec7b41356c378140fb54d510205c.1521845248.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: joe@perches.com
Cc: j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net, dmitry.tarnyagin@lockless.no, wg@grandegger.com, mkl@pengutronix.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, jpr@f6fbb.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, alex.aring@gmail.com, stefan@osg.samsung.com, andrew@lunn.ch, f.fainelli@gmail.com, paulus@samba.org, mostrows@earthlink.net, oliver@neukum.org, wei.liu2@citrix.com, paul.durrant@citrix.com, boris.ostrovsky@oracle.com, jgross@suse.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hams@vger.kernel.org, devel@linuxdriverproject.org, linux-wpan@vger.kernel.org, linux-ppp@vger.kernel.org, linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org

From: Joe Perches <joe@perches.com>
Date: Fri, 23 Mar 2018 15:54:39 -0700

> Prefer the direct use of octal for permissions.
> 
> Done with checkpatch -f --types=SYMBOLIC_PERMS --fix-inplace
> and some typing.
> 
> Miscellanea:
> 
> o Whitespace neatening around these conversions.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.
