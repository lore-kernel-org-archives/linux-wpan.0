Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64242 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752583AbdIAXSj (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Fri, 1 Sep 2017 19:18:39 -0400
From: Josef Filzmaier <j.filzmaier@gmx.at>
Subject: [PATCH bluetooth-next 0/1] *** Support for Busware HUL stick ***
Date: Sat,  2 Sep 2017 01:18:28 +0200
Message-Id: <20170901231829.31279-1-j.filzmaier@gmx.at>
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
  atusb: Driver support for Busware HUL USB dongle

 drivers/net/ieee802154/atusb.c | 314 +++++++++++++++++++++++++++++++++++------
 drivers/net/ieee802154/atusb.h |   8 ++
 2 files changed, 282 insertions(+), 40 deletions(-)

-- 
2.14.1

