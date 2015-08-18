Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55470 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608AbbHRNzA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 18 Aug 2015 09:55:00 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 669C820A92
	for <linux-wpan@vger.kernel.org>; Tue, 18 Aug 2015 09:54:59 -0400 (EDT)
In-Reply-To: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
References: <1439468568-22288-1-git-send-email-alex.aring@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC bluetooth-next 00/21] mrf24j40: async rx/tx handling and new features
From: Alan Ott <alan@signal11.us>
Date: Tue, 18 Aug 2015 06:54:51 -0700
Message-ID: <D58FB766-13F8-4113-A327-D3AA9967243B@signal11.us>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, jonatan@myeden.se, stefan@osg.samsung.com

Hi Alexander, there's definitely a lot of work represented here. I'd like to make some comments and I have some questions, but I'm on travel so it might be a few days before I get some emails out about it.

Thanks!

Alan.

On August 13, 2015 5:22:27 AM MST, Alexander Aring <alex.aring@gmail.com> wrote:
>Hi,
>
>this patch series contains some cleanups, devicetree support, rx/tx
>async
>handling, threaded irq to hardirq, csma params settings, cca mode
>settings,
>cca energy detection levels, tx power settings and promiscuous mode
>settings.
>
>Also I add regmap support, the lowlevel spi calls are only used in
>hotpaths
>for handling receive/transmit and irq handling. There are also some
>many
>magic numbers, maybe we can introduce some register bits defines.
>
>First I will send this as RFC to get some respone if the patches looks
>fine
>and acceptable for mainline.
>
>- Alex
>
>Alexander Aring (21):
>  mrf24j40: cleanup define identation
>  mrf24j40: use ieee802154_alloc_hw for private data
>  mrf24j40: calling ieee802154_register_hw at last
>  mrf24j40: remove spi settings overwrite
>  mrf24j40: add device-tree support
>  mrf24j40: add default channel setting
>  mrf24j40: add random extended addr generation
>  mrf24j40: add more register defines
>  mrf24j40: add regmap support
>  mrf24j40: use regmap for register access
>  mrf24j40: change to frame delivery with crc
>  ieee802154: add helpers for frame control checks
>  mrf24j40: rework tx handling to async tx handling
>  mrf24j40: rework rx handling to async rx handling
>  mrf24j40: async interrupt handling
>  mrf24j40: add csma params support
>  mrf24j40: add cca mode support
>  mrf24j40: add cca ed level support
>  mrf24j40: add tx power support
>  mrf24j40: add promiscuous mode support
>  mrf24j40: change irq trigger type behaviour
>
> .../bindings/net/ieee802154/mrf24j40.txt           |   20 +
> MAINTAINERS                                        |    1 +
> drivers/net/ieee802154/Kconfig                     |    1 +
>drivers/net/ieee802154/mrf24j40.c                  | 1342
>+++++++++++++-------
> include/linux/ieee802154.h                         |   29 +
> 5 files changed, 969 insertions(+), 424 deletions(-)
>create mode 100644
>Documentation/devicetree/bindings/net/ieee802154/mrf24j40.txt
>
>-- 
>2.5.0

