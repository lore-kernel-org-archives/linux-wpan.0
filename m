Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40672 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756860AbcHBOix (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 2 Aug 2016 10:38:53 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH linux-wpan/radvd for-upstream 2/2] device-linux: get address length via sysfs
Date: Tue,  2 Aug 2016 16:37:52 +0200
Message-Id: <20160802143752.12831-3-aar@pengutronix.de>
In-Reply-To: <20160802143752.12831-1-aar@pengutronix.de>
References: <20160802143752.12831-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch will change the behaviour for 6LoWPAN interface to detect the
linklayer address length via sysfs. The usually way to get the address
length is via a mapping from ARPHRD device type. This doesn't work for
6LoWPAN interfaces, we need at least some other mechanism. This patch
adds the mechanism to read out the sysfs UAPI to get the addr_len
attribute of net_device. This will not work if there are two 6LoWPAN
link-layer types with the same address length but need different
handling in userspace. For that reason I think a linklayer type would be
better, this requires a 6lowpan netlink API which doesn't exist right
now. So we use this simple way now.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 device-linux.c | 38 ++++++++++++++++++++++++++++++++++++--
 pathnames.h    |  1 +
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/device-linux.c b/device-linux.c
index 7301927..c483952 100644
--- a/device-linux.c
+++ b/device-linux.c
@@ -29,6 +29,34 @@
 static char const *hwstr(unsigned short sa_family);
 
 /*
+ * get interface address length over sysfs
+ */
+static int get_device_addr_len(struct Interface *iface)
+{
+	char path[PATH_MAX];
+	uint32_t addr_len;
+	FILE *f;
+	int ret;
+
+	ret = sprintf(path, SYS_CLASS_NET_ADDRLEN, iface->props.name);
+	if (ret < 0)
+		return -1;
+
+	f = fopen(path, "r");
+	if (!f)
+		return -1;
+
+	ret = fscanf(f, "%u", &addr_len);
+	if (ferror(f)) {
+		fclose(f);
+		return -1;
+	}
+
+	fclose(f);
+	return addr_len;
+}
+
+/*
  * this function gets the hardware type and address of an interface,
  * determines the link layer token length and checks it against
  * the defined prefixes
@@ -84,8 +112,14 @@ int update_device_info(int sock, struct Interface *iface)
 		break;
 #endif				/* ARPHDR_ARCNET */
 	case ARPHRD_6LOWPAN:
-		iface->sllao.if_hwaddr_len = 64;
-		iface->sllao.if_prefix_len = 64;
+		iface->sllao.if_hwaddr_len = get_device_addr_len(iface);
+		if (iface->sllao.if_hwaddr_len != -1) {
+			iface->sllao.if_hwaddr_len *= 8;
+			iface->sllao.if_prefix_len = 64;
+		} else {
+			iface->sllao.if_prefix_len = -1;
+		}
+
 		break;
 	default:
 		iface->sllao.if_hwaddr_len = -1;
diff --git a/pathnames.h b/pathnames.h
index 580e2b2..152bb7a 100644
--- a/pathnames.h
+++ b/pathnames.h
@@ -40,6 +40,7 @@
 #define PROC_SYS_IP6_BASEREACHTIME "/proc/sys/net/ipv6/neigh/%s/base_reachable_time"
 #define PROC_SYS_IP6_RETRANSTIMER_MS "/proc/sys/net/ipv6/neigh/%s/retrans_time_ms"
 #define PROC_SYS_IP6_RETRANSTIMER "/proc/sys/net/ipv6/neigh/%s/retrans_time"
+#define SYS_CLASS_NET_ADDRLEN "/sys/class/net/%s/addr_len"
 #else				/* BSD */
 #define SYSCTL_IP6_FORWARDING CTL_NET, PF_INET6, IPPROTO_IPV6, IPV6CTL_FORWARDING
 #endif
-- 
2.9.0

