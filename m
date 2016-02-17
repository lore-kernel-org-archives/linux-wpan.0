Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48206 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965223AbcBQJOU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 17 Feb 2016 04:14:20 -0500
From: Alexander Aring <aar@pengutronix.de>
Subject: [RFC radvd 2/2] radvd: rework 6CO handling
Date: Wed, 17 Feb 2016 10:14:15 +0100
Message-Id: <1455700455-5319-3-git-send-email-aar@pengutronix.de>
In-Reply-To: <1455700455-5319-1-git-send-email-aar@pengutronix.de>
References: <1455700455-5319-1-git-send-email-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org, reubenhwk@gmail.com, s@mlng.net, Alexander Aring <aar@pengutronix.de>

Current issues with the 6CO handling:
 - Doesn't work on little endian at my side because forgotten
   byteordering handling at bitfields.
 - There can be multiple 6CO options. Up to 16 6CO options at maximum.
 - It doesn't work as it should. Maybe for some use-case somebody need
   that, but 6CO contains information for header parsing and this need
   functionality to tell it the kernel. Currently we have a debugfs entry
   for that.

As an example, RFC6775 describes the 6LBR should be configurated and
managed the context entries of RFC6282.

interface lowpan0
{
        Adv6LBR on;
        AdvSendAdvert on;
        UnicastOnly on;
        AdvCurHopLimit 255;

        prefix 2001::/64 {
                AdvOnLink on;
                AdvAutonomous on;
                AdvRouterAddr on;
        };

        lowpanco {
                ctx 0 {
                        AdvContextCompressionFlag on;
                        AdvContextLength 64;
                        AdvContextPrefix 2001::;
                        AdvLifeTime 1000;
                };

		ctx 1 {
			...
		};

		... up to 16 ctx's ...
        };
};

If we set "Adv6LBR" to on, then the "lowpanco" contexts will be setup
during startup of radvd, otherwise all contexts are empty (non active).

I changed the parsing of contexts:
 - lowpanco contains up-to 16 contexts with _unique_ id's.
 - The id is after "ctx" specified.

What doesn't work:
 - Lifetime handling.
 - AdvContextCompressionFlag should be 0 at first to propagate "safety"
   the context inside the network. RFC6775 says here:

   New context information SHOULD be introduced into the LoWPAN with C=0,
   to ensure that it is known by all nodes that may have to perform header
   decompression based on this context information. Only when it is
   reasonable to assume that this information was successfully
   disseminated SHOULD an option with C=1 be sent, enabling the actual
   use of the context information for compression

   I know what this means, but then don't know "when" we can do "C=1",
   maybe this is out-of-scope in RFC6775.

Note:
 I ignore the ABRO for now. The ABRO need to be included and the version
 fields indicates if new context or old context information. This is
 just to begin with something to handle 6CO.

 ABRO must be included, so please add some dummy ABRO when using 6CO.

Signed-off-by: Alexander Aring <aar@pengutronix.de>
---
 defaults.h      |   3 ++
 device-bsd44.c  |  24 ++++++++++
 device-linux.c  |  32 +++++++++++++
 gram.y          |  72 ++++++++++++++++++++++------
 pathnames.h     |   4 ++
 privsep-linux.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 process.c       |  44 ++++++++++++++++++
 radvd.h         |  18 ++++++-
 scanner.l       |   2 +-
 send.c          |  32 ++++++++-----
 10 files changed, 344 insertions(+), 29 deletions(-)

diff --git a/defaults.h b/defaults.h
index fedd546..a328793 100644
--- a/defaults.h
+++ b/defaults.h
@@ -125,6 +125,9 @@
 
 #define MAX_PrefixLen			128
 
+/* RFC6282 Constraints */
+#define MAX_CIDLen			16
+
 /* SLAAC (RFC4862) Constants and Derived Values */
 #define MIN_AdvValidLifetime		7200	/* 2 hours in secs */
 
diff --git a/device-bsd44.c b/device-bsd44.c
index f1aacca..1a22e26 100644
--- a/device-bsd44.c
+++ b/device-bsd44.c
@@ -143,6 +143,30 @@ int set_interface_retranstimer(const char *iface, uint32_t rettimer)
 	return -1;
 }
 
+int set_interface_ctx_active(const char *iface, uint8_t id, uint8_t val)
+{
+	dlog(LOG_DEBUG, 4, "update 6LoWPAN context not supported");
+	return 0;
+}
+
+int set_interface_ctx_compression(const char *iface, uint8_t id, uint8_t val)
+{
+	dlog(LOG_DEBUG, 4, "update 6LoWPAN context not supported");
+	return 0;
+}
+
+int set_interface_ctx_plen(const char *iface, uint8_t id, uint8_t plen)
+{
+	dlog(LOG_DEBUG, 4, "update 6LoWPAN context not supported");
+	return 0;
+}
+
+int set_interface_ctx_pfx(const char *iface, uint8_t id, struct in6_addr pfx)
+{
+	dlog(LOG_DEBUG, 4, "update 6LoWPAN context not supported");
+	return 0;
+}
+
 int check_ip6_forwarding(void)
 {
 	dlog(LOG_DEBUG, 4, "checking ipv6 forwarding not supported");
diff --git a/device-linux.c b/device-linux.c
index 7301927..0a62634 100644
--- a/device-linux.c
+++ b/device-linux.c
@@ -86,6 +86,18 @@ int update_device_info(int sock, struct Interface *iface)
 	case ARPHRD_6LOWPAN:
 		iface->sllao.if_hwaddr_len = 64;
 		iface->sllao.if_prefix_len = 64;
+
+		if (iface->AdvLowpanCoList) {
+			for (int i = 0; i < MAX_CIDLen; i++)
+				set_interface_ctx_active(iface->props.name, i, 0);
+
+			for (struct AdvLowpanCo * current = iface->AdvLowpanCoList; current; current = current->next) {
+				set_interface_ctx_compression(iface->props.name, current->AdvContextID, current->ContextCompressionFlag);
+				set_interface_ctx_plen(iface->props.name, current->AdvContextID, current->ContextLength);
+				set_interface_ctx_pfx(iface->props.name, current->AdvContextID, current->AdvContextPrefix);
+				set_interface_ctx_active(iface->props.name, current->AdvContextID, 1);
+			}
+		}
 		break;
 	default:
 		iface->sllao.if_hwaddr_len = -1;
@@ -147,6 +159,26 @@ int setup_allrouters_membership(int sock, struct Interface *iface)
 	return 0;
 }
 
+int set_interface_ctx_active(const char *iface, uint8_t id, uint8_t val)
+{
+	return privsep_interface_ctx_active(iface, id, val);
+}
+
+int set_interface_ctx_compression(const char *iface, uint8_t id, uint8_t val)
+{
+	return privsep_interface_ctx_compression(iface, id, val);
+}
+
+int set_interface_ctx_plen(const char *iface, uint8_t id, uint8_t plen)
+{
+	return privsep_interface_ctx_plen(iface, id, plen);
+}
+
+int set_interface_ctx_pfx(const char *iface, uint8_t id, struct in6_addr pfx)
+{
+	return privsep_interface_ctx_pfx(iface, id, pfx);
+}
+
 int set_interface_linkmtu(const char *iface, uint32_t mtu)
 {
 	return privsep_interface_linkmtu(iface, mtu);
diff --git a/gram.y b/gram.y
index 1ed4aa3..6b0af23 100644
--- a/gram.y
+++ b/gram.y
@@ -53,6 +53,7 @@ static struct in6_addr get_prefix6(struct in6_addr const *addr, struct in6_addr
 %token		T_DNSSL
 %token		T_CLIENTS
 %token		T_LOWPANCO
+%token		T_CTX
 %token		T_ABRO
 
 %token	<str>	STRING
@@ -113,7 +114,6 @@ static struct in6_addr get_prefix6(struct in6_addr const *addr, struct in6_addr
 
 %token		T_AdvContextLength
 %token		T_AdvContextCompressionFlag
-%token		T_AdvContextID
 %token		T_AdvLifeTime
 %token		T_AdvContextPrefix
 
@@ -130,7 +130,7 @@ static struct in6_addr get_prefix6(struct in6_addr const *addr, struct in6_addr
 %type	<rinfo>	routedef
 %type	<rdnssinfo> rdnssdef
 %type	<dnsslinfo> dnssldef
-%type   <lowpancoinfo> lowpancodef
+%type   <lowpancoinfo> lowpancolist ctxlist
 %type   <abroinfo> abrodef
 %type   <num>	number_or_infinity
 
@@ -158,7 +158,7 @@ static struct AdvPrefix *prefix;
 static struct AdvRoute *route;
 static struct AdvRDNSS *rdnss;
 static struct AdvDNSSL *dnssl;
-static struct AdvLowpanCo *lowpanco;
+static struct AdvLowpanCo *lowpanco, *lowpanco_head;
 static struct AdvAbro  *abro;
 static void cleanup(void);
 #define ABORT	do { cleanup(); YYABORT; } while (0);
@@ -228,7 +228,7 @@ ifaceparam 	: ifaceval
 		| routedef 	{ ADD_TO_LL(struct AdvRoute, AdvRouteList, $1); }
 		| rdnssdef 	{ ADD_TO_LL(struct AdvRDNSS, AdvRDNSSList, $1); }
 		| dnssldef 	{ ADD_TO_LL(struct AdvDNSSL, AdvDNSSLList, $1); }
-		| lowpancodef   { ADD_TO_LL(struct AdvLowpanCo, AdvLowpanCoList, $1); }
+		| lowpancolist	{ ADD_TO_LL(struct AdvLowpanCo, AdvLowpanCoList, $1); }
 		| abrodef       { ADD_TO_LL(struct AdvAbro, AdvAbroList, $1); }
 		;
 
@@ -913,23 +913,55 @@ dnsslparms	: T_AdvDNSSLLifetime number_or_infinity ';'
 		}
 		;
 
-lowpancodef 	: lowpancohead  '{' optional_lowpancoplist '}' ';'
+lowpancolist   : lowpancodef  '{' ctxlist '}' ';'
+		{
+			$$ = $3;
+		}
+		;
+
+lowpancodef	: T_LOWPANCO
+		{
+			lowpanco_head = NULL;
+		}
+		;
+
+ctxlist		: ctxhead '{' optional_lowpancoplist '}' ';'
 		{
 			$$ = lowpanco;
-			lowpanco = NULL;
+		}
+		| ctxlist ctxhead '{' optional_lowpancoplist '}' ';'
+		{
+
+			if (lowpanco_head == NULL)
+				lowpanco_head = lowpanco;
+
+			lowpanco->next = $1;
+			$$ = lowpanco;
 		}
 		;
 
-lowpancohead	: T_LOWPANCO
+ctxhead		: T_CTX NUMBER
 		{
-			lowpanco = malloc(sizeof(struct AdvLowpanCo));
+			if ($2 > MAX_CIDLen - 1) {
+				flog(LOG_ERR, "invalid context id %d in %s, line %d", $2, filename, num_lines);
+				ABORT;
+			}
 
+			for (struct AdvLowpanCo * current = lowpanco_head; current; current = current->next) {
+				if ($2 == current->AdvContextID) {
+					flog(LOG_ERR, "context id %d already exists in %s, line %d", $2, filename, num_lines);
+					ABORT;
+				}
+			}
+
+			lowpanco = malloc(sizeof(struct AdvLowpanCo));
 			if (lowpanco == NULL) {
 				flog(LOG_CRIT, "malloc failed: %s", strerror(errno));
 				ABORT;
 			}
 
 			memset(lowpanco, 0, sizeof(struct AdvLowpanCo));
+			lowpanco->AdvContextID = $2;
 		}
 		;
 
@@ -943,20 +975,26 @@ lowpancoplist	: lowpancoplist lowpancoparms
 
 lowpancoparms 	: T_AdvContextLength NUMBER ';'
 		{
+			if ($2 > MAX_PrefixLen)
+			{
+				flog(LOG_ERR, "invalid context prefix length in %s, line %d", filename, num_lines);
+				ABORT;
+			}
+
 			lowpanco->ContextLength = $2;
 		}
 		| T_AdvContextCompressionFlag SWITCH ';'
 		{
 			lowpanco->ContextCompressionFlag = $2;
 		}
-		| T_AdvContextID NUMBER ';'
-		{
-			lowpanco->AdvContextID = $2;
-		}
 		| T_AdvLifeTime NUMBER ';'
 		{
 			lowpanco->AdvLifeTime = $2;
 		}
+		| T_AdvContextPrefix IPV6ADDR ';'
+		{
+			memcpy(&lowpanco->AdvContextPrefix, $2, sizeof(struct in6_addr));
+		}
 		;
 
 abrodef		: abrohead  '{' optional_abroplist '}' ';'
@@ -1102,9 +1140,15 @@ static void cleanup(void)
 		dnssl = 0;
 	}
 
-	if (lowpanco) {
-		free(lowpanco);
+	if (lowpanco_head) {
+		struct AdvLowpanCo *c = lowpanco_head, *tmp;
+		while (!c) {
+			tmp = c;
+			c = c->next;
+			free(tmp);
+		}
 		lowpanco = 0;
+		lowpanco_head = 0;
 	}
 
 	if (abro) {
diff --git a/pathnames.h b/pathnames.h
index 580e2b2..c219c7e 100644
--- a/pathnames.h
+++ b/pathnames.h
@@ -40,6 +40,10 @@
 #define PROC_SYS_IP6_BASEREACHTIME "/proc/sys/net/ipv6/neigh/%s/base_reachable_time"
 #define PROC_SYS_IP6_RETRANSTIMER_MS "/proc/sys/net/ipv6/neigh/%s/retrans_time_ms"
 #define PROC_SYS_IP6_RETRANSTIMER "/proc/sys/net/ipv6/neigh/%s/retrans_time"
+#define DEBUGFS_6LOWPAN_CTX_ACTIVE "/sys/kernel/debug/6lowpan/%s/contexts/%d/active"
+#define DEBUGFS_6LOWPAN_CTX_COMPRESSION "/sys/kernel/debug/6lowpan/%s/contexts/%d/compression"
+#define DEBUGFS_6LOWPAN_CTX_PREFIX "/sys/kernel/debug/6lowpan/%s/contexts/%d/prefix"
+#define DEBUGFS_6LOWPAN_CTX_PREFIX_LEN "/sys/kernel/debug/6lowpan/%s/contexts/%d/prefix_len"
 #else				/* BSD */
 #define SYSCTL_IP6_FORWARDING CTL_NET, PF_INET6, IPPROTO_IPV6, IPV6CTL_FORWARDING
 #endif
diff --git a/privsep-linux.c b/privsep-linux.c
index a48f52a..bdaf94a 100644
--- a/privsep-linux.c
+++ b/privsep-linux.c
@@ -22,6 +22,9 @@
 static int set_interface_var(const char *iface, const char *var, const char *name, uint32_t val);
 static void privsep_read_loop(void);
 
+static int set_interface_ctx_var(const char *iface, const char *var, const char *name, uint32_t id, uint32_t val);
+static int __set_interface_ctx_pfx(const char *iface, const char *var, const char *name, uint32_t id, struct in6_addr pfx);
+
 /* For reading or writing, depending on process */
 static int pfd = -1;
 
@@ -36,6 +39,10 @@ enum privsep_type {
 	SET_INTERFACE_CURHLIM,
 	SET_INTERFACE_REACHTIME,
 	SET_INTERFACE_RETRANSTIMER,
+	SET_INTERFACE_CTX_ACTIVE,
+	SET_INTERFACE_CTX_COMPRESSION,
+	SET_INTERFACE_CTX_PFX,
+	SET_INTERFACE_CTX_PLEN,
 };
 
 /* Command sent over pipe is a fixed size binary structure. */
@@ -43,6 +50,9 @@ struct privsep_command {
 	int type;
 	char iface[IFNAMSIZ];
 	uint32_t val;
+	/* 6lowpan */
+	uint32_t id;
+	struct in6_addr pfx;
 };
 
 /* Privileged read loop */
@@ -112,6 +122,34 @@ static void privsep_read_loop(void)
 			set_interface_var(cmd.iface, PROC_SYS_IP6_RETRANSTIMER, "RetransTimer", cmd.val / 1000 * USER_HZ);	/* XXX user_hz */
 			break;
 
+		case SET_INTERFACE_CTX_ACTIVE:
+			if (cmd.val != 0 && cmd.val != 1) {
+				flog(LOG_ERR, "(privsep) %s: 6CO %u active flag (%u) is not within the defined bounds, ignoring",
+				     cmd.iface, cmd.id, cmd.val);
+				break;
+			}
+			ret = set_interface_ctx_var(cmd.iface, DEBUGFS_6LOWPAN_CTX_ACTIVE, "6CO active flag (bool)", cmd.id, cmd.val);
+			break;
+		case SET_INTERFACE_CTX_COMPRESSION:
+			if (cmd.val != 0 && cmd.val != 1) {
+				flog(LOG_ERR, "(privsep) %s: 6CO %u compression flag (%u) is not within the defined bounds, ignoring",
+				     cmd.iface, cmd.id, cmd.val);
+				break;
+			}
+			ret = set_interface_ctx_var(cmd.iface, DEBUGFS_6LOWPAN_CTX_COMPRESSION, "6CO compression flag (bool)", cmd.id, cmd.val);
+			break;
+		case SET_INTERFACE_CTX_PFX:
+			ret = __set_interface_ctx_pfx(cmd.iface, DEBUGFS_6LOWPAN_CTX_PREFIX, "6CO prefix", cmd.id, cmd.pfx);
+			break;
+		case SET_INTERFACE_CTX_PLEN:
+			if (cmd.val > MAX_PrefixLen) {
+				flog(LOG_ERR, "(privsep) %s: 6CO %u prefix length (%u) is not within the defined bounds, ignoring",
+				     cmd.iface, cmd.id, cmd.val);
+				break;
+			}
+			ret = set_interface_ctx_var(cmd.iface, DEBUGFS_6LOWPAN_CTX_PREFIX_LEN, "6CO prefix length", cmd.id, cmd.val);
+			break;
+
 		default:
 			/* Bad command */
 			break;
@@ -174,12 +212,59 @@ int privsep_interface_retranstimer(const char *iface, uint32_t rettimer)
 	return 0;
 }
 
+int privsep_interface_ctx_active(const char *iface, uint32_t id, uint32_t active)
+{
+	struct privsep_command cmd;
+	cmd.type = SET_INTERFACE_CTX_ACTIVE;
+	strncpy(cmd.iface, iface, sizeof(cmd.iface));
+	cmd.id = id;
+	cmd.val = active;
+	if (writen(pfd, &cmd, sizeof(cmd)) != sizeof(cmd))
+		return -1;
+	return 0;
+}
+
+int privsep_interface_ctx_compression(const char *iface, uint32_t id, uint32_t c)
+{
+	struct privsep_command cmd;
+	cmd.type = SET_INTERFACE_CTX_COMPRESSION;
+	strncpy(cmd.iface, iface, sizeof(cmd.iface));
+	cmd.id = id;
+	cmd.val = c;
+	if (writen(pfd, &cmd, sizeof(cmd)) != sizeof(cmd))
+		return -1;
+	return 0;
+}
+
+int privsep_interface_ctx_pfx(const char *iface, uint32_t id, struct in6_addr pfx)
+{
+	struct privsep_command cmd;
+	cmd.type = SET_INTERFACE_CTX_PFX;
+	strncpy(cmd.iface, iface, sizeof(cmd.iface));
+	cmd.id = id;
+	cmd.pfx = pfx;
+	if (writen(pfd, &cmd, sizeof(cmd)) != sizeof(cmd))
+		return -1;
+	return 0;
+}
+
+int privsep_interface_ctx_plen(const char *iface, uint32_t id, uint32_t plen)
+{
+	struct privsep_command cmd;
+	cmd.type = SET_INTERFACE_CTX_PLEN;
+	strncpy(cmd.iface, iface, sizeof(cmd.iface));
+	cmd.id = id;
+	cmd.val = plen;
+	if (writen(pfd, &cmd, sizeof(cmd)) != sizeof(cmd))
+		return -1;
+	return 0;
+}
+
 /* note: also called from the root context */
-static int set_interface_var(const char *iface, const char *var, const char *name, uint32_t val)
+static int __set_interface_var(char * spath, const char *iface, const char *var, const char *name, uint32_t val)
 {
 	int retval = -1;
 	FILE * fp = 0;
-	char * spath = strdupf(var, iface);
 
 	/* No path traversal */
 	if (!iface[0] || !strcmp(iface, ".") || !strcmp(iface, "..") || strchr(iface, '/'))
@@ -210,3 +295,56 @@ cleanup:
 	return retval;
 }
 
+/* note: also called from the root context */
+static int set_interface_var(const char *iface, const char *var, const char *name, uint32_t val)
+{
+	char * spath = strdupf(var, iface);
+
+	return __set_interface_var(spath, iface, var, name, val);
+}
+
+/* note: also called from the root context */
+static int set_interface_ctx_var(const char *iface, const char *var, const char *name, uint32_t id, uint32_t val)
+{
+	char * spath = strdupf(var, iface, id);
+
+	return __set_interface_var(spath, iface, var, name, val);
+}
+
+/* note: also called from the root context */
+static int __set_interface_ctx_pfx(const char *iface, const char *var, const char *name, uint32_t id, struct in6_addr pfx)
+{
+	int retval = -1;
+	FILE * fp = 0;
+	char * spath = strdupf(var, iface, id);
+
+	/* No path traversal */
+	if (!iface[0] || !strcmp(iface, ".") || !strcmp(iface, "..") || strchr(iface, '/'))
+		goto cleanup;
+
+	if (access(spath, F_OK) != 0)
+		goto cleanup;
+
+	fp = fopen(spath, "w");
+	if (!fp) {
+		if (name)
+			flog(LOG_ERR, "failed to set %s (%pI6c) for %s: %s", name, &pfx, iface, strerror(errno));
+		goto cleanup;
+	}
+
+	if (0 > fprintf(fp, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x",
+			be16toh(pfx.s6_addr16[0]), be16toh(pfx.s6_addr16[1]), be16toh(pfx.s6_addr16[2]), be16toh(pfx.s6_addr16[3]),
+			be16toh(pfx.s6_addr16[4]), be16toh(pfx.s6_addr16[5]), be16toh(pfx.s6_addr16[6]), be16toh(pfx.s6_addr16[7]))) {
+		goto cleanup;
+	}
+
+	retval = 0;
+
+cleanup:
+	if (fp)
+		fclose(fp);
+
+	free(spath);
+
+	return retval;
+}
diff --git a/process.c b/process.c
index a6050ad..68e27ea 100644
--- a/process.c
+++ b/process.c
@@ -385,6 +385,50 @@ static void process_ra(struct Interface *iface, unsigned char *msg, int len, str
 				}
 				break;
 			}
+		case ND_OPT_6CO: {
+				struct nd_opt_6co *ctxinfo = (struct nd_opt_6co *)opt_str;
+				struct in6_addr pfx = {};
+
+				/* check if we can evaluate the len field */
+				if (len < 2)
+					return;
+
+				switch (ctxinfo->nd_opt_6co_len) {
+				case 2:
+					if (len < (sizeof(*ctxinfo) - 8))
+						return;
+
+					memcpy(&pfx, &ctxinfo->nd_opt_6co_con_prefix, 8);
+					break;
+				case 3:
+					if (len < (sizeof(*ctxinfo)))
+						return;
+
+					memcpy(&pfx, &ctxinfo->nd_opt_6co_con_prefix, 16);
+					break;
+				default:
+					return;
+				}
+
+				if (ctxinfo->nd_opt_6co_cid > MAX_CIDLen - 1)
+					return;
+
+				/* If the Valid Lifetime field in the 6CO is zero, then the entry is immediately deleted. */
+				if (!ctxinfo->nd_opt_6co_valid_lifetime)
+					set_interface_ctx_active(iface->props.name, ctxinfo->nd_opt_6co_cid, 0);
+				else {
+					/* disable it while updating context */
+					set_interface_ctx_active(iface->props.name, ctxinfo->nd_opt_6co_cid, 0);
+
+					set_interface_ctx_pfx(iface->props.name, ctxinfo->nd_opt_6co_cid, pfx);
+					set_interface_ctx_plen(iface->props.name, ctxinfo->nd_opt_6co_cid, ctxinfo->nd_opt_6co_context_len);
+					set_interface_ctx_compression(iface->props.name, ctxinfo->nd_opt_6co_cid, ctxinfo->nd_opt_6co_c);
+
+					/* enable it again */
+					set_interface_ctx_active(iface->props.name, ctxinfo->nd_opt_6co_cid, 1);
+				}
+				break;
+			}
 		default:
 			dlog(LOG_DEBUG, 1, "unknown option %d in RA on %s from %s", (int)*opt_str, iface->props.name, addr_str);
 			break;
diff --git a/radvd.h b/radvd.h
index f557bf3..97b52d4 100644
--- a/radvd.h
+++ b/radvd.h
@@ -187,7 +187,7 @@ struct AdvDNSSL {
 	struct AdvDNSSL *next;
 };
 
-/* Options for 6lopan configuration */
+/* Options for 6lowpan configuration */
 
 struct AdvLowpanCo {
 	uint8_t ContextLength;
@@ -242,9 +242,17 @@ struct nd_opt_6co {
 	uint8_t nd_opt_6co_type;
 	uint8_t nd_opt_6co_len;
 	uint8_t nd_opt_6co_context_len;
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	uint8_t nd_opt_6co_cid:4;
+	uint8_t nd_opt_6co_c:1;
+	uint8_t nd_opt_6co_res:3;
+#elif __BYTE_ORDER == __BIG_ENDIAN
 	uint8_t nd_opt_6co_res:3;
 	uint8_t nd_opt_6co_c:1;
 	uint8_t nd_opt_6co_cid:4;
+#else
+#error "no byte order specified!"
+#endif
 	uint16_t nd_opt_6co_reserved;
 	uint16_t nd_opt_6co_valid_lifetime;
 	struct in6_addr nd_opt_6co_con_prefix;
@@ -269,6 +277,10 @@ int set_interface_curhlim(const char *, uint8_t);
 int set_interface_linkmtu(const char *, uint32_t);
 int set_interface_reachtime(const char *, uint32_t);
 int set_interface_retranstimer(const char *, uint32_t);
+int set_interface_ctx_active(const char *iface, uint8_t id, uint8_t val);
+int set_interface_ctx_compression(const char *iface, uint8_t id, uint8_t val);
+int set_interface_ctx_plen(const char *iface, uint8_t id, uint8_t plen);
+int set_interface_ctx_pfx(const char *iface, uint8_t id, struct in6_addr pfx);
 int setup_allrouters_membership(int sock, struct Interface *);
 int setup_linklocal_addr(struct Interface *);
 int setup_linklocal_addr(struct Interface *iface);
@@ -321,6 +333,10 @@ int privsep_interface_curhlim(const char *iface, uint32_t hlim);
 int privsep_interface_linkmtu(const char *iface, uint32_t mtu);
 int privsep_interface_reachtime(const char *iface, uint32_t rtime);
 int privsep_interface_retranstimer(const char *iface, uint32_t rettimer);
+int privsep_interface_ctx_active(const char *iface, uint32_t id, uint32_t active);
+int privsep_interface_ctx_compression(const char *iface, uint32_t id, uint32_t c);
+int privsep_interface_ctx_pfx(const char *iface, uint32_t id, struct in6_addr pfx);
+int privsep_interface_ctx_plen(const char *iface, uint32_t id, uint32_t plen);
 void privsep_init(int);
 void privsep_set_write_fd(int);
 
diff --git a/scanner.l b/scanner.l
index 164a834..07602bf 100644
--- a/scanner.l
+++ b/scanner.l
@@ -49,6 +49,7 @@ RDNSS			{ return T_RDNSS; }
 DNSSL			{ return T_DNSSL; }
 clients			{ return T_CLIENTS; }
 lowpanco		{ return T_LOWPANCO; }
+ctx			{ return T_CTX; }
 abro			{ return T_ABRO; }
 
 IgnoreIfMissing		{ return T_IgnoreIfMissing; }
@@ -102,7 +103,6 @@ AdvMobRtrSupportFlag	{ return T_AdvMobRtrSupportFlag; }
 
 AdvContextLength	{ return T_AdvContextLength; }
 AdvContextCompressionFlag { return T_AdvContextCompressionFlag; }
-AdvContextID		{ return T_AdvContextID; }
 AdvLifeTime		{ return T_AdvLifeTime; }
 AdvContextPrefix	{ return T_AdvContextPrefix; }
 
diff --git a/send.c b/send.c
index 96ded05..06281c6 100644
--- a/send.c
+++ b/send.c
@@ -35,7 +35,7 @@ static void add_mtu(struct safe_buffer * sb, uint32_t AdvLinkMTU);
 static void add_sllao(struct safe_buffer * sb, struct sllao const *sllao);
 static void add_mipv6_rtr_adv_interval(struct safe_buffer * sb, double MaxRtrAdvInterval);
 static void add_mipv6_home_agent_info(struct safe_buffer * sb, struct mipv6 const * mipv6);
-static void add_lowpanco(struct safe_buffer * sb, struct AdvLowpanCo const *lowpanco);
+static void add_lowpanco(struct safe_buffer * sb, struct AdvLowpanCo *lowpanco);
 static void add_abro(struct safe_buffer * sb, struct AdvAbro const *abroo);
 
 #ifdef UNIT_TEST
@@ -540,21 +540,31 @@ static void add_mipv6_home_agent_info(struct safe_buffer * sb, struct mipv6 cons
 /*
  * Add 6co option
  */
-static void add_lowpanco(struct safe_buffer * sb, struct AdvLowpanCo const *lowpanco)
+static void add_lowpanco(struct safe_buffer * sb, struct AdvLowpanCo *lowpanco)
 {
 	struct nd_opt_6co co;
+	size_t nd_opt_6co_size;
 
-	memset(&co, 0, sizeof(co));
+	for (struct AdvLowpanCo * current = lowpanco; current; current = current->next) {
+		memset(&co, 0, sizeof(co));
 
-	co.nd_opt_6co_type = ND_OPT_6CO;
-	co.nd_opt_6co_len = 3;
-	co.nd_opt_6co_context_len = lowpanco->ContextLength;
-	co.nd_opt_6co_c = lowpanco->ContextCompressionFlag;
-	co.nd_opt_6co_cid = lowpanco->AdvContextID;
-	co.nd_opt_6co_valid_lifetime = lowpanco->AdvLifeTime;
-	co.nd_opt_6co_con_prefix = lowpanco->AdvContextPrefix;
+		co.nd_opt_6co_type = ND_OPT_6CO;
+		co.nd_opt_6co_context_len = current->ContextLength;
+		if (co.nd_opt_6co_context_len > 64) {
+			co.nd_opt_6co_len = 3;
+			nd_opt_6co_size = sizeof(co);
+		} else {
+			co.nd_opt_6co_len = 2;
+			nd_opt_6co_size = sizeof(co) - 8;
+		}
+		co.nd_opt_6co_c = current->ContextCompressionFlag;
+		co.nd_opt_6co_cid = current->AdvContextID;
+		co.nd_opt_6co_valid_lifetime = current->AdvLifeTime;
+		co.nd_opt_6co_con_prefix = current->AdvContextPrefix;
 
-	safe_buffer_append(sb, &co, sizeof(co));
+		safe_buffer_append(sb, &co, nd_opt_6co_size);
+
+	}
 }
 
 static void add_abro(struct safe_buffer * sb, struct AdvAbro const *abroo)
-- 
2.7.1

