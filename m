Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31522 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbaKDIzV (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 03:55:21 -0500
Date: Tue, 4 Nov 2014 11:55:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ieee802154: || vs && in ieee802154_is_valid_extended_addr()
Message-ID: <20141104085509.GA12954@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141104000139.GA23799@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

The ieee802154_is_valid_extended_addr() always returns true because
there is a typo.  The || should be &&.  Neither 0x0000000000000000ULL
nor 0xffffffffffffffffULL are valid addresses.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
index 5d9e745..4c03286 100644
--- a/include/linux/ieee802154.h
+++ b/include/linux/ieee802154.h
@@ -209,7 +209,7 @@ static inline bool ieee802154_is_valid_extended_addr(const __le64 addr)
 	 * This is currently a workaround because neighbor discovery can't
 	 * deal with short addresses types right now.
 	 */
-	return ((addr != cpu_to_le64(0x0000000000000000ULL)) ||
+	return ((addr != cpu_to_le64(0x0000000000000000ULL)) &&
 		(addr != cpu_to_le64(0xffffffffffffffffULL)));
 }
 
