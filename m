Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:36513 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbdC1Nf0 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 28 Mar 2017 09:35:26 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v9 0/3] ieee802154: Add support for Cascoda CA8210
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170328120900.5328-1-h.morris@cascoda.com>
Date: Tue, 28 Mar 2017 15:34:48 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <B3740BD8-23A8-47E4-9F8D-DAE013C5411D@holtmann.org>
References: <20170328120900.5328-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Harry Morris <harrymorris12@gmail.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Harry Morris <h.morris@cascoda.com>

Hi Harry,

> This patchset adds a new device driver, documentation and build support for
> Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
> http://www.cascoda.com/products/ca-821x/
> 
> v9:
> Add promiscuous mode support
> Rework SPI retries
> Fix printf typo
> Remove old TODOs
> add "select COMMON_CLK" to Kconfig entry
> 
> v8:
> Use module_spi_driver helper
> Remove async tx timeout at driver level
> Style conformance change
> Rework synchronous command handling to remove mutex
> 
> v7:
> Remove use of cs_change property, always transmit full length buffers
> Implement fully async spi transfers
> Combine spi transmission and reception into one function
> Use completion objects when waiting for events
> Rework a lot of locking
> Remove deprecated xmit_sync
> Remove use of workqueue for IRQ handling
> 
> v6:
> Kernel style conformance changes
> Additional documentation
> More meaningful register structs/macros
> Removal of old TODOs
> Removal of unnecessary macros
> Check for safe removal of test interface
> 
> v5:
> +Cc: Marcel Holtmann
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
> drivers/net/ieee802154/Kconfig                     |   22 +
> drivers/net/ieee802154/Makefile                    |    1 +
> drivers/net/ieee802154/ca8210.c                    | 3240 ++++++++++++++++++++
> 6 files changed, 3301 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/ieee802154/ca8210.txt
> create mode 100644 drivers/net/ieee802154/ca8210.c

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

