Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:57339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751580AbdINMcS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 14 Sep 2017 08:32:18 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: [PATCH bluetooth-next v2 0/1] ieee802154: atusb: Driver for Busware HUL dongle
Date: Thu, 14 Sep 2017 14:32:09 +0200
Message-Id: <20170914123210.3765-1-j.filzmaier@gmx.at>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Josef Filzmaier <j.filzmaier@gmx.at>

This patch introduces support for the Busware HUL stick. There is also a
corresponding patch for the atusb firmware. It uses the code of the at86rf212
driver from at86rf230.c and modifies it to work with the atusb firmware. It
now also separates between device types like atusb, rzusb and hulusb and
initializes the driver accordingly.

Josef Filzmaier (1):
  ieee802154: atusb: Driver for Busware HUL dongle

 drivers/net/ieee802154/atusb.c | 317 +++++++++++++++++++++++++++++++++++------
 drivers/net/ieee802154/atusb.h |   8 ++
 2 files changed, 285 insertions(+), 40 deletions(-)

-- 
2.14.1

