Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:43250 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbcLHGj1 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Dec 2016 01:39:27 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH v6 0/3] ieee802154: Add support for Cascoda CA8210
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20161206154740.2992-1-h.morris@cascoda.com>
Date: Thu, 8 Dec 2016 07:39:24 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <EE6B2599-12C7-4B55-AFA5-E88C6BF8A942@holtmann.org>
References: <20161206154740.2992-1-h.morris@cascoda.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: harrymorris12@gmail.com
Cc: linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>, Harry Morris <h.morris@cascoda.com>

Hi Harry,

> This patchset adds a new device driver, documentation and build support for
> Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
> http://www.cascoda.com/products/ca-821x/
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

so I am missing PATCH 1/3 again. How large is it? You need to put me on CC if it does not go via vger.kernel.org.

Regards

Marcel

