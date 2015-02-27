Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:41477 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbB0Rns convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Feb 2015 12:43:48 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCHv5 bluetooth-next 0/6] at86rf230: support for xtal trim and irq fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 27 Feb 2015 09:43:12 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <88DD8812-18BA-4850-BD0B-524CE06217B6@holtmann.org>
References: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, mkl@pengutronix.de, Werner Almesberger <werner@almesberger.net>, Thomas Stilwell <stilwellt@openlabs.co>

Hi Alex,

> I moved the xtal_trim calculation example of available free schematics
> hardware transceivers into the source code now.
> 
> While testing I experience some issues with interrupt handling. The reason
> was an edge triggered interrupt gpio. To protect the IRQ resources we have
> a disable_irq <-> enable_irq path in our irq handler. If edge triggered and
> we get an irq while the irq is disabled the transceiver stucks in a state.
> The solution was to change from edge triggered irq to high-level irq, this
> will solve the issue and the irq will fire after calling enable_irq.
> 
> That's the reason why we should prever a high-level triggered gpio irq type,
> our current implementation can't handle edge triggered irq right now.
> I added some patches to printout a warning if a edge triggered irq is set.
> 
> - Alex
> 
> changes since v5:
> - move note about xtal_trim value to driver code
> - add patch to remove tx_timeout
> - add patch for irqmask mode setting
> - add patch for handling low-level irq polarity
> - add patch for adding warning for edge triggered irq types
> 
> changes since v4:
> - remove platform data from at86rf230_local
> - add note in cover-letter because at86rf2xx have different xtal_mode values
> 
> changes since v3:
> - remove setting of xtal_mode. Instead we setting xtal_trim only.
> 
> changes since v2:
> - copy platform data to driver allocated space
> 
> Cc: Werner Almesberger <werner@almesberger.net>
> Cc: Thomas Stilwell <stilwellt@openlabs.co>
> 
> Alexander Aring (6):
>  at86rf230: copy pdata to driver allocated space
>  at86rf230: add support for external xtal trim
>  at86rf230: remove tx_timeout
>  at86rf230: add irqmask mode setting
>  at86rf230: add irq low-level for polarity
>  at86rf230: add warning if edge-triggered irq
> 
> .../bindings/net/ieee802154/at86rf230.txt          |   8 +-
> drivers/net/ieee802154/at86rf230.c                 | 118 +++++++++++++++------
> include/linux/spi/at86rf230.h                      |   1 +
> 3 files changed, 91 insertions(+), 36 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

