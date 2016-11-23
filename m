Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:35963 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933453AbcKWTuZ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 23 Nov 2016 14:50:25 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH v4 0/3] ieee802154: Add support for Cascoda CA8210
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161123102500.5980-1-h.morris@cascoda.com>
Date: Wed, 23 Nov 2016 20:50:21 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <7B5768E2-33C9-48EF-82C4-5E56516361FD@holtmann.org>
References: <20161123102500.5980-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Harry Morris <h.morris@cascoda.com>

Hi Harry,

> This patchset adds a new device driver, documentation and build support for
> Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
> http://www.cascoda.com/products/ca-821x/
> 
> v4:
> Added allowable tx_powers and cca_ed_levels
> Changed power units to mbm (tx_power & cca_ed_level) 
> 
> Harry Morris (3):
>  ieee802154: Add CA8210 IEEE 802.15.4 device driver
>  ieee802154: Add device tree documentation for CA8210
>  ieee802154: Add entry in MAINTAINTERS for CA8210 driver
> 
> .../devicetree/bindings/net/ieee802154/ca8210.txt  |   28 +
> .../devicetree/bindings/vendor-prefixes.txt        |    1 +
> MAINTAINERS                                        |    9 +
> drivers/net/ieee802154/Kconfig                     |   18 +
> drivers/net/ieee802154/Makefile                    |    1 +
> drivers/net/ieee802154/ca8210.c                    | 3665 ++++++++++++++++++++
> 6 files changed, 3722 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
> create mode 100644 drivers/net/ieee802154/ca8210.c

can you send a v5 and include me on CC. I am always missing the actual driver patch. I guess it is too large for the mailing list.

Regards

Marcel

