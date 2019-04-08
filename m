Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53961 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbfDHQIP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Apr 2019 12:08:15 -0400
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH] MAINTAINERS: ieee802154: update documentation file pattern
Date: Mon,  8 Apr 2019 18:08:04 +0200
Message-Id: <20190408160804.1617-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-wpan@vger.kernel.org, aring@mojatatu.com, Stefan Schmidt <stefan@datenfreihafen.org>

When moving the documentation for the ieee802154 subsystem from
plain text to rst the file pattern in the MAINTAINERS file got wrong.
Updating it here to fix scripts using this file.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6771bd784f5f..621622138860 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7515,7 +7515,7 @@ F:	include/net/mac802154.h
 F:	include/net/af_ieee802154.h
 F:	include/net/cfg802154.h
 F:	include/net/ieee802154_netdev.h
-F:	Documentation/networking/ieee802154.txt
+F:	Documentation/networking/ieee802154.rst
 
 IFE PROTOCOL
 M:	Yotam Gigi <yotam.gi@gmail.com>
-- 
2.17.2
