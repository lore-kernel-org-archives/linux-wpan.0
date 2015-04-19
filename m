Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:50773 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbDSQAz (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 19 Apr 2015 12:00:55 -0400
Received: from honk.sigxcpu.org (localhost [127.0.0.1])
	by photon.sigxcpu.org (Postfix) with ESMTPS id AC950695
	for <linux-wpan@vger.kernel.org>; Sun, 19 Apr 2015 18:00:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 3DEC3FB03
	for <linux-wpan@vger.kernel.org>; Sun, 19 Apr 2015 18:00:53 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5FN-BpzOg9Uq for <linux-wpan@vger.kernel.org>;
	Sun, 19 Apr 2015 18:00:52 +0200 (CEST)
Date: Sun, 19 Apr 2015 18:00:33 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: [wpan-tools] Use PRIu64 for formatting uint64_t
Message-ID: <20150419160033.GA7869@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

This fixes:

CC       iwpan-interface.o
interface.c: In function ‘print_iface_handler’:
interface.c:206:10: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘uint64_t’ [-Wformat=]
          le64toh(nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR])));
          ^

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 src/interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/interface.c b/src/interface.c
index 904b96e..5e0ef89 100644
--- a/src/interface.c
+++ b/src/interface.c
@@ -2,6 +2,7 @@
 #include <errno.h>
 #include <string.h>
 #include <stdbool.h>
+#include <inttypes.h>
 
 #include <netlink/genl/genl.h>
 #include <netlink/genl/family.h>
@@ -202,7 +203,7 @@ static int print_iface_handler(struct nl_msg *msg, void *arg)
 		printf("%s\twpan_dev 0x%llx\n", indent,
 		       (unsigned long long)nla_get_u64(tb_msg[NL802154_ATTR_WPAN_DEV]));
 	if (tb_msg[NL802154_ATTR_EXTENDED_ADDR])
-		printf("%s\textended_addr 0x%016llx\n", indent,
+		printf("%s\textended_addr 0x%016" PRIu64 "\n", indent,
 		       le64toh(nla_get_u64(tb_msg[NL802154_ATTR_EXTENDED_ADDR])));
 	if (tb_msg[NL802154_ATTR_SHORT_ADDR])
 		printf("%s\tshort_addr 0x%04x\n", indent,
-- 
2.1.4
