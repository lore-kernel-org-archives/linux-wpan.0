Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41189 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758604AbcHDNLO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Aug 2016 09:11:14 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCHv2 linux-wpan/radvd for-upstream 2/2] device-linux: get address length via netlink
Date: Thu,  4 Aug 2016 15:09:32 +0200
Message-Id: <20160804130932.4429-4-aar@pengutronix.de>
In-Reply-To: <20160804130932.4429-1-aar@pengutronix.de>
References: <20160804130932.4429-1-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, linux-bluetooth@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

This patch adds a mechanism to get the device address length via
netlink. This is necessary for device type 6LoWPAN which can have
different device address lengths.
---
 device-linux.c | 16 +++++++++++++--
 netlink.c      | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netlink.h      |  1 +
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/device-linux.c b/device-linux.c
index 7301927..1ccb207 100644
--- a/device-linux.c
+++ b/device-linux.c
@@ -17,6 +17,7 @@
 #include "radvd.h"
 #include "defaults.h"
 #include "pathnames.h"
+#include "netlink.h"
 
 #ifndef IPV6_ADDR_LINKLOCAL
 #define IPV6_ADDR_LINKLOCAL   0x0020U
@@ -84,8 +85,19 @@ int update_device_info(int sock, struct Interface *iface)
 		break;
 #endif				/* ARPHDR_ARCNET */
 	case ARPHRD_6LOWPAN:
-		iface->sllao.if_hwaddr_len = 64;
-		iface->sllao.if_prefix_len = 64;
+#ifdef HAVE_NETLINK
+		/* hwaddr length differs on some L2 type lets detect them */
+		iface->sllao.if_hwaddr_len = netlink_get_device_addr_len(iface);
+		if (iface->sllao.if_hwaddr_len != -1) {
+			iface->sllao.if_hwaddr_len *= 8;
+			iface->sllao.if_prefix_len = 64;
+		} else {
+			iface->sllao.if_prefix_len = -1;
+		}
+#else
+		iface->sllao.if_hwaddr_len = -1;
+		iface->sllao.if_prefix_len = -1;
+#endif
 		break;
 	default:
 		iface->sllao.if_hwaddr_len = -1;
diff --git a/netlink.c b/netlink.c
index 80d2254..d07a0b8 100644
--- a/netlink.c
+++ b/netlink.c
@@ -32,6 +32,70 @@
 #define SOL_NETLINK	270
 #endif
 
+struct iplink_req {
+	struct nlmsghdr		n;
+	struct ifinfomsg	i;
+	char			buf[1024];
+};
+
+int netlink_get_device_addr_len(struct Interface *iface)
+{
+	struct iplink_req req = {};
+	struct iovec iov = { &req, sizeof(req) };
+	struct sockaddr_nl sa = {};
+	struct msghdr msg = { (void *)&sa, sizeof(sa), &iov, 1, NULL, 0, 0 };
+	int sock, len, addr_len = -1;
+	unsigned short type;
+	char answer[32768];
+	struct rtattr *tb;
+
+	/* nl_pid (for linux kernel) and nl_groups (unicast) should be zero */
+	sa.nl_family = AF_NETLINK;
+	req.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
+	req.n.nlmsg_flags = NLM_F_REQUEST;
+	req.n.nlmsg_type = RTM_GETLINK;
+	req.i.ifi_index = iface->props.if_index;
+
+	sock = netlink_socket();
+	if (sock == -1)
+		return -1;
+
+	len = sendmsg(sock, &msg, 0);
+	if (len == -1) {
+		flog(LOG_ERR, "netlink: sendmsg for addr_len failed: %s", strerror(errno));
+		close(sock);
+		goto out;
+	}
+
+	iov.iov_base = answer;
+	iov.iov_len = sizeof(answer);
+	len = recvmsg(sock, &msg, 0);
+	if (len == -1) {
+		flog(LOG_ERR, "netlink: recvmsg for addr_len failed: %s", strerror(errno));
+		close(sock);
+		goto out;
+	}
+
+	if (len < NLMSG_LENGTH(sizeof(struct ifinfomsg)))
+		goto out;
+	len -= NLMSG_LENGTH(sizeof(struct ifinfomsg));
+
+	tb = (struct rtattr *)(answer + NLMSG_LENGTH(sizeof(struct ifinfomsg)));
+	while (RTA_OK(tb, len)) {
+		type = tb->rta_type & ~NLA_F_NESTED;
+		if (type == IFLA_ADDRESS) {
+			addr_len = RTA_PAYLOAD(tb);
+			break;
+		}
+		tb = RTA_NEXT(tb, len);
+	}
+
+out:
+	close(sock);
+
+	return addr_len;
+}
+
 void process_netlink_msg(int sock, struct Interface * ifaces)
 {
 	char buf[4096];
diff --git a/netlink.h b/netlink.h
index e2b706e..c693a10 100644
--- a/netlink.h
+++ b/netlink.h
@@ -17,5 +17,6 @@
 
 #include "radvd.h"
 
+int netlink_get_device_addr_len(struct Interface *iface);
 void process_netlink_msg(int sock, struct Interface * ifaces);
 int netlink_socket(void);
-- 
2.9.2

