Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:53646 "EHLO
	proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbcDVPl5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 22 Apr 2016 11:41:57 -0400
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next 5/9] libnl: nla_put_s64(): align on a 64-bit area
Date: Fri, 22 Apr 2016 17:31:20 +0200
Message-Id: <1461339084-3849-6-git-send-email-nicolas.dichtel@6wind.com>
In-Reply-To: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
References: <1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org, aar@pengutronix.de, pablo@netfilter.org, kaber@trash.net, kadlec@blackhole.kfki.hu, pshelar@nicira.com, kuznet@ms2.inr.ac.ru, jmorris@namei.org, yoshfuji@linux-ipv6.org, netfilter-devel@vger.kernel.org, dev@openvswitch.org, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, bsingharora@gmail.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>

nla_data() is now aligned on a 64-bit area.
In fact, there is no user of this function.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/net/netlink.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 066a921e7cbe..074215a59d19 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -102,7 +102,8 @@
  *   nla_put_s8(skb, type, value)	add s8 attribute to skb
  *   nla_put_s16(skb, type, value)	add s16 attribute to skb
  *   nla_put_s32(skb, type, value)	add s32 attribute to skb
- *   nla_put_s64(skb, type, value)	add s64 attribute to skb
+ *   nla_put_s64(skb, type, value,
+ *               padattr)		add s64 attribute to skb
  *   nla_put_string(skb, type, str)	add string attribute to skb
  *   nla_put_flag(skb, type)		add flag attribute to skb
  *   nla_put_msecs(skb, type, jiffies)	add msecs attribute to skb
@@ -929,14 +930,16 @@ static inline int nla_put_s32(struct sk_buff *skb, int attrtype, s32 value)
 }
 
 /**
- * nla_put_s64 - Add a s64 netlink attribute to a socket buffer
+ * nla_put_s64 - Add a s64 netlink attribute to a socket buffer and align it
  * @skb: socket buffer to add attribute to
  * @attrtype: attribute type
  * @value: numeric value
+ * @padattr: attribute type for the padding
  */
-static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value)
+static inline int nla_put_s64(struct sk_buff *skb, int attrtype, s64 value,
+			      int padattr)
 {
-	return nla_put(skb, attrtype, sizeof(s64), &value);
+	return nla_put_64bit(skb, attrtype, sizeof(s64), &value, padattr);
 }
 
 /**
-- 
2.8.1

