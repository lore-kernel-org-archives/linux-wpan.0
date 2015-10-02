Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31098 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbJBHru (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Oct 2015 03:47:50 -0400
Date: Fri, 2 Oct 2015 10:47:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] nl802154: Missing return in nl802154_add_llsec_key()
Message-ID: <20151002074729.GA16768@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151002071958.GA565@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, kernel-janitors@vger.kernel.org

There was a missing return here so it meant that often
ieee802154_llsec_parse_key_id() was not called.

Fixes: a26c5fd7622d ('nl802154: add support for security layer')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 1e9e865..16ef0d9 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -1534,6 +1534,7 @@ static int nl802154_add_llsec_key(struct sk_buff *skb, struct genl_info *info)
 
 	if (!attrs[NL802154_KEY_ATTR_USAGE_FRAMES] ||
 	    !attrs[NL802154_KEY_ATTR_BYTES])
+		return -EINVAL;
 
 	if (ieee802154_llsec_parse_key_id(attrs[NL802154_KEY_ATTR_ID], &id) < 0)
 		return -ENOBUFS;
