Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47605 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751935AbcFUPDQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Tue, 21 Jun 2016 11:03:16 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH linux-wpan/radvd 6lowpan] device-linux: detect 6LoWPAN lltype for hwaddr length
Date: Tue, 21 Jun 2016 16:42:50 +0200
Message-Id: <20160621144250.31650-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, kernel@pengutronix.de, patrik.flykt@linux.intel.com, jukka.rissanen@linux.intel.com, Alexander Aring <aar@pengutronix.de>

This patch will change the behaviour for 6LoWPAN interface to detect the
linklayer type via debugfs. Each L2 interface has a different address
length and need to be detected.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
We have two choices (or even more):

 - Add lltype like this patch to detect the hwaddr length

 or

 - Add a UAPI to get the hwaddr length doesn't depend on lltype

I did the first choice now, because it works like the net core api which
also has no UAPI for addr length. To get the address length you need to
map it to the netdev type. But this also means that a netdev type should
not have different hardware addresses.

In 6LoWPAN this is different, the ARPHRD_6LOWPAN can have different address
lengths. Jukka please tell me if this is fine or not, I usually don't want
to make things for ARPHRD_6LOWPAN link-layer specific, but we need to add
some solution for this.

My different UAPI solution is shown above, don't know which is actually
better. I think we need for some cases an UAPI to get the link-layer
type anyway.

btw: as fallback it use the olf behaviour 64 bit's so if we fix btle 6lowpan
to work with dev->addr_len = 6 and introduce the UAPI it will be fixed
automatically.

Later we need to move this stuff to sysfs. Debugfs is also not namespace
aware and because that it forbids me to make some special testing stuff.

 device-linux.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 pathnames.h    |  1 +
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/device-linux.c b/device-linux.c
index 55f8522..3d18071 100644
--- a/device-linux.c
+++ b/device-linux.c
@@ -60,6 +60,42 @@ static uint16_t lowpan_get_short_addr(struct Interface *iface)
 }
 
 /*
+ * sync with kernel so far we have no uapi header
+ */
+enum lowpan_lltypes {
+	LOWPAN_LLTYPE_BTLE,
+	LOWPAN_LLTYPE_IEEE802154,
+};
+
+/*
+ * get 6lowpan link layer type identifier
+ */
+static uint32_t lowpan_get_lltype(struct Interface *iface)
+{
+	char path[PATH_MAX];
+	uint32_t lltype;
+	FILE *f;
+	int ret;
+
+	ret = sprintf(path, DEBUGFS_6LOWPAN_LLTYPE, iface->props.name);
+	if (ret < 0)
+		return UINT32_MAX;
+
+	f = fopen(path, "r");
+	if (!f)
+		return UINT32_MAX;
+
+	ret = fscanf(f, "%d", &lltype);
+	if (ferror(f)) {
+		fclose(f);
+		return UINT32_MAX;
+	}
+
+	fclose(f);
+	return lltype;
+}
+
+/*
  * this function gets the hardware type and address of an interface,
  * determines the link layer token length and checks it against
  * the defined prefixes
@@ -115,7 +151,21 @@ int update_device_info(int sock, struct Interface *iface)
 		break;
 #endif				/* ARPHDR_ARCNET */
 	case ARPHRD_6LOWPAN:
-		iface->sllao.if_hwaddr_len = 64;
+		/* hwaddr length differs on each L2 type lets detect them */
+		switch (lowpan_get_lltype(iface)) {
+		case LOWPAN_LLTYPE_BTLE:
+			iface->sllao.if_hwaddr_len = 48;
+			break;
+		case LOWPAN_LLTYPE_IEEE802154:
+			iface->sllao.if_hwaddr_len = 64;
+			break;
+		default:
+			/* TODO change to -1 if 6LoWPAN has better UAPI for that */
+			flog(LOG_WARNING, "WARNING, couldn't get 6LoWPAN link-layer type on %s, falling back to 64 bit hwaddr", iface->props.name);
+			iface->sllao.if_hwaddr_len = 64;
+			break;
+		}
+
 		iface->sllao.if_prefix_len = 64;
 		/* for 802.15.4 only, all others L2 should fail and assign invalid address */
 		iface->short_addr = lowpan_get_short_addr(iface);
diff --git a/pathnames.h b/pathnames.h
index 0d3017b..c597ea0 100644
--- a/pathnames.h
+++ b/pathnames.h
@@ -40,6 +40,7 @@
 #define PROC_SYS_IP6_BASEREACHTIME "/proc/sys/net/ipv6/neigh/%s/base_reachable_time"
 #define PROC_SYS_IP6_RETRANSTIMER_MS "/proc/sys/net/ipv6/neigh/%s/retrans_time_ms"
 #define PROC_SYS_IP6_RETRANSTIMER "/proc/sys/net/ipv6/neigh/%s/retrans_time"
+#define DEBUGFS_6LOWPAN_LLTYPE "/sys/kernel/debug/6lowpan/%s/lltype"
 #define DEBUGFS_6LOWPAN_CTX_ACTIVE "/sys/kernel/debug/6lowpan/%s/contexts/%d/active"
 #define DEBUGFS_6LOWPAN_CTX_COMPRESSION "/sys/kernel/debug/6lowpan/%s/contexts/%d/compression"
 #define DEBUGFS_6LOWPAN_CTX_PREFIX "/sys/kernel/debug/6lowpan/%s/contexts/%d/prefix"
-- 
2.9.0

