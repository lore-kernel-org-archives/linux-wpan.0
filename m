Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:56983 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752851AbdC0OLe (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Mar 2017 10:11:34 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v7 0/6] Bluetooth: 6LoWPAN: Fix lladdr length
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170312081938.11700-1-luiz.dentz@gmail.com>
Date: Mon, 27 Mar 2017 16:11:31 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <2401EDE0-D958-4158-B862-29091259BBC5@holtmann.org>
References: <20170312081938.11700-1-luiz.dentz@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: linux-bluetooth@vger.kernel.org, patrik.flykt@linux.intel.com, aar@pengutronix.de, jukka.rissanen@linux.intel.com, linux-wpan@vger.kernel.org, netdev@vger.kernel.org

Hi Luiz,

> These patches fixes lladdr length to be 6 bytes long and not 8 which cause
> neighbor advertisement to be sent with wrong lladdr including FF:FE filler
> bytes for eui64.
> 
> Note: This does not fix some of the existing crashes which I hope to address
> in a different set.
> 
> v2: Make all code paths that generate a link-local from lladdr use the same
> code.
> v3: Use lowpan_iphc_uncompress_eui48_lladdr to generate the remote ip address.
> v4: Handle comments from Stefan Schmidt.
> v5: Add patch to fix IID format for Bluetooth
> v6: Fix addrconf_ifid_eui48 to follow IID format for Bluetooth
> v7: Rework addrconf_ifid_6lowpan so it doesn't use addrconf_ifid_eui48
> 
> Alexander Aring (2):
>  6lowpan: iphc: override l2 packet information
>  ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration
> 
> Luiz Augusto von Dentz (2):
>  6lowpan: Use netdev addr_len to determine lladdr len
>  6lowpan: Fix IID format for Bluetooth
> 
> Patrik Flykt (2):
>  bluetooth: Set 6 byte device addresses
>  6lowpan: Set MAC address length according to LOWPAN_LLTYPE
> 
> include/net/6lowpan.h   |  15 ++++++
> net/6lowpan/core.c      |  11 +++-
> net/6lowpan/iphc.c      |  57 +++++++++++++++++----
> net/bluetooth/6lowpan.c | 130 ++++++++----------------------------------------
> net/ipv6/addrconf.c     |  23 ++++++---
> 5 files changed, 109 insertions(+), 127 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

