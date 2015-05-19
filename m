Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56842 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbbESMTI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 08:19:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mac802154: select CRYPTO when needed
Date: Tue, 19 May 2015 14:18:35 +0200
Message-ID: <4189396.LhxDXkIPfr@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The mac802154 subsystem uses functions from the crypto layer and correctly
selects the individual crypto algorithms, but fails to build when the
crypto layer is disabled altogether:

crypto/built-in.o: In function `crypto_ctr_free':
:(.text+0x80): undefined reference to `crypto_drop_spawn'
crypto/built-in.o: In function `crypto_rfc3686_free':
:(.text+0xac): undefined reference to `crypto_drop_spawn'
crypto/built-in.o: In function `crypto_ctr_crypt':
:(.text+0x2f0): undefined reference to `blkcipher_walk_virt_block'
:(.text+0x2f8): undefined reference to `crypto_inc'

To solve that, this patch also selects the core crypto code,
like all other users of that code do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found in ARM randconfig testing

diff --git a/net/mac802154/Kconfig b/net/mac802154/Kconfig
index aa462b480a39..b355989c63b3 100644
--- a/net/mac802154/Kconfig
+++ b/net/mac802154/Kconfig
@@ -1,6 +1,7 @@
 config MAC802154
 	tristate "Generic IEEE 802.15.4 Soft Networking Stack (mac802154)"
 	depends on IEEE802154
+	select CRYPTO
 	select CRC_CCITT
 	select CRYPTO_AUTHENC
 	select CRYPTO_CCM

