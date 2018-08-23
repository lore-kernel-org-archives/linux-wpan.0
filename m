Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40121 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbeHWUuF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Aug 2018 16:50:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id s13-v6so2958815pfi.7
        for <linux-wpan@vger.kernel.org>; Thu, 23 Aug 2018 10:19:23 -0700 (PDT)
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC 2/3 net] lorawan: Add macro and definition for LoRaWAN class modlue
Date: Fri, 24 Aug 2018 01:15:42 +0800
Message-Id: <f7ea222671a2bc6fe0a060c4bdb1ebae162d0d91.1535039998.git.starnight@g.ncu.edu.tw>
In-Reply-To: <cover.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>, =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, =?UTF-8?q?Konstantin=20B=C3=B6hm?= <konstantin.boehm@ancud.de>, Jan Jongboom <jan.jongboom@arm.com>, Jon Ortego <Jon.Ortego@imst.de>, "contact@snootlab.com" <contact@snootlab.com>, Ben Whitten <ben.whitten@lairdtech.com>, Brian Ray <brian.ray@link-labs.com>, lora@globalsat.com.tw, Alexander Graf <agraf@suse.de>, =?UTF-8?q?Michal=20Kube=C4=8Dek?= <mkubecek@suse.cz>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Steve deRosier <derosier@gmail.com>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Pieter ROBYNS <pieter.robyns@uhasselt.be>, Hasnain Virk <Hasnain.Virk@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>, Daniele Comel <dcomel@mipot.com>, shess@hessware.de, Xue Liu <liuxuenetmail@gmail.com>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>

This patch add the macro and definition for the implementation of
LoRaWAN protocol.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 include/linux/socket.h              | 5 ++++-
 include/uapi/linux/if_arp.h         | 1 +
 include/uapi/linux/if_ether.h       | 1 +
 net/core/dev.c                      | 4 ++--
 security/selinux/hooks.c            | 4 +++-
 security/selinux/include/classmap.h | 4 +++-
 6 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index aa1e288b1659..e5c8381fd1aa 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -209,8 +209,9 @@ struct ucred {
 				 */
 #define AF_XDP		44	/* XDP sockets			*/
 #define AF_LORA		45	/* LoRa sockets			*/
+#define AF_LORAWAN	46	/* LoRaWAN sockets			*/
 
-#define AF_MAX		46	/* For now.. */
+#define AF_MAX		47	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -261,6 +262,7 @@ struct ucred {
 #define PF_SMC		AF_SMC
 #define PF_XDP		AF_XDP
 #define PF_LORA		AF_LORA
+#define PF_LORAWAN	AF_LORAWAN
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */
@@ -343,6 +345,7 @@ struct ucred {
 #define SOL_KCM		281
 #define SOL_TLS		282
 #define SOL_XDP		283
+#define SOL_LORAWAN	284
 
 /* IPX options */
 #define IPX_TYPE	1
diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 1ed7cb3f2129..2376f7839355 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -99,6 +99,7 @@
 #define ARPHRD_6LOWPAN	825		/* IPv6 over LoWPAN             */
 #define ARPHRD_VSOCKMON	826		/* Vsock monitor header		*/
 #define ARPHRD_LORA	827		/* LoRa				*/
+#define ARPHRD_LORAWAN	828		/* LoRaWAN			*/
 
 #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
 #define ARPHRD_NONE	  0xFFFE	/* zero header length */
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 45644dcf5b39..b1ac70d4a377 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -148,6 +148,7 @@
 					 * aggregation protocol
 					 */
 #define ETH_P_LORA	0x00FA		/* LoRa				*/
+#define ETH_P_LORAWAN	0x00FB		/* LoRaWAN			*/
 
 /*
  *	This is an Ethernet frame header.
diff --git a/net/core/dev.c b/net/core/dev.c
index f68122f0ab02..b95ce79ec5a8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -297,7 +297,7 @@ static const unsigned short netdev_lock_type[] = {
 	 ARPHRD_IRDA, ARPHRD_FCPP, ARPHRD_FCAL, ARPHRD_FCPL,
 	 ARPHRD_FCFABRIC, ARPHRD_IEEE80211, ARPHRD_IEEE80211_PRISM,
 	 ARPHRD_IEEE80211_RADIOTAP, ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
-	 ARPHRD_IEEE802154, ARPHRD_VOID, ARPHRD_NONE};
+	 ARPHRD_IEEE802154, ARPHRD_LORAWAN, ARPHRD_VOID, ARPHRD_NONE};
 
 static const char *const netdev_lock_name[] = {
 	"_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
@@ -314,7 +314,7 @@ static const char *const netdev_lock_name[] = {
 	"_xmit_IRDA", "_xmit_FCPP", "_xmit_FCAL", "_xmit_FCPL",
 	"_xmit_FCFABRIC", "_xmit_IEEE80211", "_xmit_IEEE80211_PRISM",
 	"_xmit_IEEE80211_RADIOTAP", "_xmit_PHONET", "_xmit_PHONET_PIPE",
-	"_xmit_IEEE802154", "_xmit_VOID", "_xmit_NONE"};
+	"_xmit_IEEE802154", "_xmit_LORAWAN", "_xmit_VOID", "_xmit_NONE"};
 
 static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
 static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index aaf520a689d8..0da3a1d69cb8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1477,7 +1477,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 			return SECCLASS_XDP_SOCKET;
 		case PF_LORA:
 			return SECCLASS_LORA_SOCKET;
-#if PF_MAX > 46
+		case PF_LORAWAN:
+			return SECCLASS_LORAWAN_SOCKET;
+#if PF_MAX > 47
 #error New address family defined, please update this function.
 #endif
 		}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 060d4bf8385e..fa0151fe6f32 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,9 +244,11 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "lora_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "lorawan_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
 	{ NULL }
   };
 
-#if PF_MAX > 46
+#if PF_MAX > 47
 #error New address family defined, please update secclass_map.
 #endif
-- 
2.18.0
