Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35449 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeIAB4K (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 31 Aug 2018 21:56:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so6594743wmc.0
        for <linux-wpan@vger.kernel.org>; Fri, 31 Aug 2018 14:46:46 -0700 (PDT)
From: Xue Liu <liuxuenetmail@gmail.com>
Subject: [PATCH 0/2] ieee802154: mcr20a: clean and improve the driver
Date: Fri, 31 Aug 2018 23:46:40 +0200
Message-Id: <20180831214642.30711-1-liuxuenetmail@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org, stefan@datenfreihafen.org, alex.aring@gmail.com

The first patch replaces the magic numer with defined constants to make
the IRQ state more clearly.

The second patch removes the struct mcr20a_platform_data since it is not
widely used. Meanwhile gpiod family APIs are used to handle reset pin.

Xue Liu (2):
  ieee802154: mcr20a: Replace magic number with constants
  ieee802154: mcr20a: Remove struct mcr20a_platform_data

 drivers/net/ieee802154/mcr20a.c | 72 ++++++++-------------------------
 1 file changed, 17 insertions(+), 55 deletions(-)

-- 
2.17.0
