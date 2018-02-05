Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from osg.samsung.com ([64.30.133.232]:50168 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752294AbeBEKny (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 5 Feb 2018 05:43:54 -0500
Subject: Re: [PATCH 0/3] ieee802154: Add support for NXP MCR20A
References: <1517691074-20306-1-git-send-email-liuxuenetmail@gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <dc0e4227-9e35-afac-f1ec-7b0699789f61@osg.samsung.com>
Date: Mon, 5 Feb 2018 11:43:48 +0100
MIME-Version: 1.0
In-Reply-To: <1517691074-20306-1-git-send-email-liuxuenetmail@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org

Hello.


On 02/03/2018 09:51 PM, Xue Liu wrote:
> This patchset adds a new device driver, documentation and build support for
> NXP's MCR20A IEEE 802.15.4 radio transceiver:
> https://www.nxp.com/products/wireless-connectivity/thread/2.4-ghz-802.15.4-wireless-transceiver:MCR20A
>
> Xue Liu (3):
>   ieee802154: Add device tree documentation for MCR20A
>   ieee802154: Add entry in MAINTAINTERS for MCR20a driver
>   ieee802154: Add MCR20A IEEE 802.15.4 device driver
>
>  .../devicetree/bindings/net/ieee802154/mcr20a.txt  |   23 +
>  MAINTAINERS                                        |    8 +
>  drivers/net/ieee802154/Kconfig                     |   11 +
>  drivers/net/ieee802154/Makefile                    |    1 +
>  drivers/net/ieee802154/mcr20a.c                    | 1482 ++++++++++++++++++++
>  drivers/net/ieee802154/mcr20a.h                    |  498 +++++++
>  6 files changed, 2023 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ieee802154/mcr20a.txt
>  create mode 100644 drivers/net/ieee802154/mcr20a.c
>  create mode 100644 drivers/net/ieee802154/mcr20a.h

Great to see this patchset for a new driver. I just came back from FOSDEM and I am not sure if I will be able to review the set this week
but it is on my list and I will hurry up to come to it.

regards
Stefan Schmidt
