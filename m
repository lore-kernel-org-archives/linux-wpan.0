Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:37407 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbB0I7T (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Feb 2015 03:59:19 -0500
Received: by wesw55 with SMTP id w55so18499794wes.4
        for <linux-wpan@vger.kernel.org>; Fri, 27 Feb 2015 00:59:18 -0800 (PST)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv5 bluetooth-next 0/6] at86rf230: support for xtal trim and irq fixes
Date: Fri, 27 Feb 2015 09:58:24 +0100
Message-Id: <1425027510-2672-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, mkl@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Werner Almesberger <werner@almesberger.net>, Thomas Stilwell <stilwellt@openlabs.co>

Hi,

I moved the xtal_trim calculation example of available free schematics
hardware transceivers into the source code now.

While testing I experience some issues with interrupt handling. The reason
was an edge triggered interrupt gpio. To protect the IRQ resources we have
a disable_irq <-> enable_irq path in our irq handler. If edge triggered and
we get an irq while the irq is disabled the transceiver stucks in a state.
The solution was to change from edge triggered irq to high-level irq, this
will solve the issue and the irq will fire after calling enable_irq.

That's the reason why we should prever a high-level triggered gpio irq type,
our current implementation can't handle edge triggered irq right now.
I added some patches to printout a warning if a edge triggered irq is set.

- Alex

changes since v5:
 - move note about xtal_trim value to driver code
 - add patch to remove tx_timeout
 - add patch for irqmask mode setting
 - add patch for handling low-level irq polarity
 - add patch for adding warning for edge triggered irq types

changes since v4:
 - remove platform data from at86rf230_local
 - add note in cover-letter because at86rf2xx have different xtal_mode values

changes since v3:
 - remove setting of xtal_mode. Instead we setting xtal_trim only.

changes since v2:
 - copy platform data to driver allocated space

Cc: Werner Almesberger <werner@almesberger.net>
Cc: Thomas Stilwell <stilwellt@openlabs.co>

Alexander Aring (6):
  at86rf230: copy pdata to driver allocated space
  at86rf230: add support for external xtal trim
  at86rf230: remove tx_timeout
  at86rf230: add irqmask mode setting
  at86rf230: add irq low-level for polarity
  at86rf230: add warning if edge-triggered irq

 .../bindings/net/ieee802154/at86rf230.txt          |   8 +-
 drivers/net/ieee802154/at86rf230.c                 | 118 +++++++++++++++------
 include/linux/spi/at86rf230.h                      |   1 +
 3 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.3.0

