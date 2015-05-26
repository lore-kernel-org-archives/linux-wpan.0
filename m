Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from hmm.wantstofly.org ([148.251.232.15]:53029 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbbEZOCE (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 10:02:04 -0400
Date: Tue, 26 May 2015 15:06:10 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH bluetooth-next] mac802154: Avoid rtnl deadlock in
 mac802154_wpan_ioctl().
Message-ID: <20150526120610.GT11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

->ndo_do_ioctl() can be entered with the rtnl lock already held,
for example when sending a wext ioctl to a device (in which case
the rtnl lock is taken by wext_ioctl_dispatch()), but
mac802154_wpan_ioctl() currently unconditionally takes the rtnl
lock on entry, which can cause deadlocks.

To fix this, bail out of mac802154_wpan_ioctl() before taking the
rtnl lock if the ioctl cmd is not one of the cmds we implement.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
Acked-by: Alexander Aring <alex.aring@gmail.com>
---
 net/mac802154/iface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac802154/iface.c b/net/mac802154/iface.c
index f30788d..b544b5d 100644
--- a/net/mac802154/iface.c
+++ b/net/mac802154/iface.c
@@ -62,6 +62,9 @@ mac802154_wpan_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 		(struct sockaddr_ieee802154 *)&ifr->ifr_addr;
 	int err = -ENOIOCTLCMD;
 
+	if (cmd != SIOCGIFADDR && cmd != SIOCSIFADDR)
+		return err;
+
 	rtnl_lock();
 
 	switch (cmd) {
-- 
2.1.0
