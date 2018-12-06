Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:53428 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeLFU03 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Dec 2018 15:26:29 -0500
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/2] examples: fix wrongly used unsigned attribute
Date: Thu,  6 Dec 2018 21:26:02 +0100
Message-Id: <20181206202602.22176-2-stefan@datenfreihafen.org>
In-Reply-To: <20181206202602.22176-1-stefan@datenfreihafen.org>
References: <20181206202602.22176-1-stefan@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: aring@mojatatu.com, Stefan Schmidt <stefan@datenfreihafen.org>

We are passing this buffer into sprintf later which
expects signed. Its a constant string anyway, so
it does not matter for us. Fixes -Wpointer-sign values
spotted by our CI system.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 examples/af_ieee802154_tx.c | 2 +-
 examples/af_inet6_tx.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/examples/af_ieee802154_tx.c b/examples/af_ieee802154_tx.c
index e85a109..faad17e 100644
--- a/examples/af_ieee802154_tx.c
+++ b/examples/af_ieee802154_tx.c
@@ -55,7 +55,7 @@ int main(int argc, char *argv[]) {
 	int sd;
 	ssize_t len;
 	struct sockaddr_ieee802154 dst;
-	unsigned char buf[MAX_PACKET_LEN + 1];
+	char buf[MAX_PACKET_LEN + 1];
 	/* IEEE 802.15.4 extended send address, adapt to your setup */
 	uint8_t long_addr[IEEE802154_ADDR_LEN] = {0xd6, 0x55, 0x2c, 0xd6, 0xe4, 0x1c, 0xeb, 0x57};
 
diff --git a/examples/af_inet6_tx.c b/examples/af_inet6_tx.c
index 9fe7491..a62f730 100644
--- a/examples/af_inet6_tx.c
+++ b/examples/af_inet6_tx.c
@@ -35,7 +35,7 @@ int main(int argc, char *argv[]) {
 	int ret, sd;
 	struct sockaddr_in6 dst;
 	struct ifreq ifr;
-	unsigned char buf[MAX_PACKET_LEN + 1];
+	char buf[MAX_PACKET_LEN + 1];
 
 	/* Create IPv6 address family socket for the SOCK_DGRAM type */
 	sd = socket(PF_INET6, SOCK_DGRAM, 0);
-- 
2.17.2
