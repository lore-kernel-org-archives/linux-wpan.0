Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33326 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752587AbbHJH3M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Aug 2015 03:29:12 -0400
Message-ID: <BLU168-W12778BE0A70F0EA756A9E8CD6700@phx.gbl>
From: LIYONG <sdliyong@gmail.com>
Subject: [PATCHv1 bluetooth-next] cc2520: set the default fifo pin value
 from platform data
Date: Mon, 10 Aug 2015 15:29:07 +0800
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "varkabhadram@gmail.com" <varkabhadram@gmail.com>, "alex.aring@gmail.com" <alex.aring@gmail.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: YONG LI <sdliyong@gmail.com>

In case of the device tree support is disabled, the fifo_pin is uninitialized, this
patch will set the fifo_pin value based on platform data

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 drivers/net/ieee802154/cc2520.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
index 613dae5..c5b54a1 100644
--- a/drivers/net/ieee802154/cc2520.c
+++ b/drivers/net/ieee802154/cc2520.c
@@ -833,6 +833,7 @@ static int cc2520_get_platform_data(struct spi_device *spi,
                if (!spi_pdata)
                        return -ENOENT;
                *pdata = *spi_pdata;
+               priv->fifo_pin = pdata->fifo;
                return 0;
        }

--
2.1.0

 		 	   		  