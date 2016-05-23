Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57036 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751790AbcEWTdI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Mon, 23 May 2016 15:33:08 -0400
From: Alexander Aring <aar@pengutronix.de>
Subject: [PATCH linux-wpan/radvd 6lowpan] radvd: add handling for 802.15.4 short addr sllao
Date: Mon, 23 May 2016 21:32:52 +0200
Message-Id: <1464031972-17833-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <aar@pengutronix.de>

This patch adds handling for adding the 802.15.4 short address in RA as
sllao if available. All others 6LoWPAN layers and if getting of short
address failed, we don't add a short address sllao in there.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 defaults.h     |  3 +++
 device-linux.c | 33 +++++++++++++++++++++++++++++++++
 interface.c    |  1 +
 pathnames.h    |  1 +
 radvd.h        |  2 ++
 send.c         | 23 +++++++++++++++++------
 6 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/defaults.h b/defaults.h
index a328793..8462d39 100644
--- a/defaults.h
+++ b/defaults.h
@@ -127,6 +127,9 @@
 
 /* RFC6282 Constraints */
 #define MAX_CIDLen			16
+#define SHORT_ADDR_BROADCAST		0xffff
+#define SHORT_ADDR_UNSPEC		0xfffe
+#define SHORT_ADDR_BITS_LEN		16
 
 /* SLAAC (RFC4862) Constants and Derived Values */
 #define MIN_AdvValidLifetime		7200	/* 2 hours in secs */
diff --git a/device-linux.c b/device-linux.c
index 0a62634..22ea503 100644
--- a/device-linux.c
+++ b/device-linux.c
@@ -29,6 +29,37 @@
 static char const *hwstr(unsigned short sa_family);
 
 /*
+ * this function gets the short address which is available on 802,15.4
+ * 6lowpan only. All others will return an invalid address which is the
+ * broadcast address. If it's a valid address it will be added to RA
+ * messages.
+ */
+static uint16_t lowpan_get_short_addr(struct Interface *iface)
+{
+	unsigned int short_addr;
+	char path[PATH_MAX];
+	FILE *f;
+	int ret;
+
+	ret = sprintf(path, DEBUGFS_6LOWPAN_SHORT_ADDR, iface->props.name);
+	if (ret < 0)
+		return SHORT_ADDR_BROADCAST;
+
+	f = fopen(path, "r");
+	if (!f)
+		return SHORT_ADDR_BROADCAST;
+
+	ret = fscanf(f, "0x%04x", &short_addr);
+	if (ret == EOF && ferror(f)) {
+		fclose(f);
+		return SHORT_ADDR_BROADCAST;
+	}
+
+	fclose(f);
+	return short_addr;
+}
+
+/*
  * this function gets the hardware type and address of an interface,
  * determines the link layer token length and checks it against
  * the defined prefixes
@@ -86,6 +117,8 @@ int update_device_info(int sock, struct Interface *iface)
 	case ARPHRD_6LOWPAN:
 		iface->sllao.if_hwaddr_len = 64;
 		iface->sllao.if_prefix_len = 64;
+		/* for 802.15.4 only, all others L2 should fail and assign invalid address */
+		iface->short_addr = lowpan_get_short_addr(iface);
 
 		if (iface->AdvLowpanCoList) {
 			for (int i = 0; i < MAX_CIDLen; i++)
diff --git a/interface.c b/interface.c
index d09a1e7..68bc97e 100644
--- a/interface.c
+++ b/interface.c
@@ -47,6 +47,7 @@ void iface_init_defaults(struct Interface *iface)
 
 	iface->AdvLinkMTU = DFLT_AdvLinkMTU;
 
+	iface->short_addr = SHORT_ADDR_BROADCAST;
 }
 
 
diff --git a/pathnames.h b/pathnames.h
index c219c7e..4cd04a7 100644
--- a/pathnames.h
+++ b/pathnames.h
@@ -44,6 +44,7 @@
 #define DEBUGFS_6LOWPAN_CTX_COMPRESSION "/sys/kernel/debug/6lowpan/%s/contexts/%d/compression"
 #define DEBUGFS_6LOWPAN_CTX_PREFIX "/sys/kernel/debug/6lowpan/%s/contexts/%d/prefix"
 #define DEBUGFS_6LOWPAN_CTX_PREFIX_LEN "/sys/kernel/debug/6lowpan/%s/contexts/%d/prefix_len"
+#define DEBUGFS_6LOWPAN_SHORT_ADDR "/sys/kernel/debug/6lowpan/%s/short_addr"
 #else				/* BSD */
 #define SYSCTL_IP6_FORWARDING CTL_NET, PF_INET6, IPPROTO_IPV6, IPV6CTL_FORWARDING
 #endif
diff --git a/radvd.h b/radvd.h
index 2540a82..1ba875c 100644
--- a/radvd.h
+++ b/radvd.h
@@ -102,6 +102,8 @@ struct Interface {
 		int if_maxmtu;
 	} sllao;
 
+	uint16_t short_addr;
+
 	struct mipv6 {
 		/* Mobile IPv6 extensions */
 		int AdvIntervalOpt;
diff --git a/send.c b/send.c
index 06281c6..7b3444a 100644
--- a/send.c
+++ b/send.c
@@ -32,7 +32,8 @@ static void add_rdnss(struct safe_buffer * sb, struct AdvRDNSS const *rdnss, int
 static size_t serialize_domain_names(struct safe_buffer * safe_buffer, struct AdvDNSSL const *dnssl);
 static void add_dnssl(struct safe_buffer * sb, struct AdvDNSSL const *dnssl, int cease_adv);
 static void add_mtu(struct safe_buffer * sb, uint32_t AdvLinkMTU);
-static void add_sllao(struct safe_buffer * sb, struct sllao const *sllao);
+static void add_sllao(struct safe_buffer * sb, const uint8_t *if_hwaddr,
+		      int if_hwaddr_len);
 static void add_mipv6_rtr_adv_interval(struct safe_buffer * sb, double MaxRtrAdvInterval);
 static void add_mipv6_home_agent_info(struct safe_buffer * sb, struct mipv6 const * mipv6);
 static void add_lowpanco(struct safe_buffer * sb, struct AdvLowpanCo *lowpanco);
@@ -431,7 +432,8 @@ static void add_dnssl(struct safe_buffer * safe_buffer, struct AdvDNSSL const *d
 /*
  * add Source Link-layer Address option
  */
-static void add_sllao(struct safe_buffer * sb, struct sllao const *sllao)
+static void add_sllao(struct safe_buffer * sb, const uint8_t *if_hwaddr,
+		      int if_hwaddr_len)
 {
 	/* *INDENT-OFF* */
 	/*
@@ -467,14 +469,14 @@ static void add_sllao(struct safe_buffer * sb, struct sllao const *sllao)
 	/* *INDENT-ON* */
 
 	/* +2 for the ND_OPT_SOURCE_LINKADDR and the length (each occupy one byte) */
-	size_t const sllao_bytes = (sllao->if_hwaddr_len / 8) + 2;
+	size_t const sllao_bytes = (if_hwaddr_len / 8) + 2;
 	size_t const sllao_len = (sllao_bytes + 7) / 8;
 
 	uint8_t buff[2] = {ND_OPT_SOURCE_LINKADDR, (uint8_t)sllao_len};
 	safe_buffer_append(sb, buff, sizeof(buff));
 
 	/* if_hwaddr_len is in bits, so divide by 8 to get the byte count. */
-	safe_buffer_append(sb, sllao->if_hwaddr, sllao->if_hwaddr_len / 8);
+	safe_buffer_append(sb, if_hwaddr, if_hwaddr_len / 8);
 	safe_buffer_pad(sb, sllao_len * 8 - sllao_bytes);
 }
 
@@ -608,8 +610,17 @@ static void build_ra(struct safe_buffer * sb, struct Interface const * iface)
 		add_mtu(sb, iface->AdvLinkMTU);
 	}
 
-	if (iface->AdvSourceLLAddress && iface->sllao.if_hwaddr_len > 0) {
-		add_sllao(sb, &iface->sllao);
+	if (iface->AdvSourceLLAddress) {
+		if (iface->sllao.if_hwaddr_len > 0) {
+			add_sllao(sb, iface->sllao.if_hwaddr, iface->sllao.if_hwaddr_len);
+		}
+
+		/* add second sllao for 802.15.4 short address */
+		if (iface->short_addr != SHORT_ADDR_BROADCAST && iface->short_addr != SHORT_ADDR_UNSPEC) {
+			uint16_t short_addr_be = htons(iface->short_addr);
+
+			add_sllao(sb, (const uint8_t *)&short_addr_be, SHORT_ADDR_BITS_LEN);
+		}
 	}
 
 	if (iface->mipv6.AdvIntervalOpt) {
-- 
2.8.2

