Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17BDC433EF
	for <linux-wpan@archiver.kernel.org>; Thu, 26 May 2022 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344230AbiEZQ2X (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 26 May 2022 12:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiEZQ2U (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 26 May 2022 12:28:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B895D5FC;
        Thu, 26 May 2022 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653582499; x=1685118499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gOdOMyeM/Ewif0zQ3Hqg7oUO5xeNmrmmhTh727FQsQQ=;
  b=b+R2I/ZsN1zv8YoiwtLite1sqpcEo3hmJ3l+qvJiHDwvNqWIwlnl506n
   MMDOA0o3f4JHLl6D38QfcU+qEVlqSagE1mOvip9l7gW0g+YwKHlZQu7P6
   FZe+EMIBUTnE0YB2AIMr07GD82TSUePZcBO+yxwE4JuzJ94Rp1amXiZRy
   BRzzGPDKJXrADFBttZLfyJDe0P+NygysDuvWECQtRh4VDXK4Fxbg6MwID
   8P2c0iSHnOGY9AbpTBRHaJWHk3YU3aVMdiGFWUB6Xv3khds7mUAMDHwz/
   7Sz0VIcj9BCc4aisO5PpDlZdZaeweAl5Dj5Rz6Kzpwy70vJYlfrCksBga
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="256274815"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256274815"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:28:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="560275628"
Received: from jsamoilo-mobl1.ger.corp.intel.com (HELO jrissane-mobl2.fritz.box) ([10.252.41.200])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 09:28:16 -0700
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     alex.aring@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Remove me as maintainer of 6lowpan
Date:   Thu, 26 May 2022 19:28:06 +0300
Message-Id: <20220526162806.16618-1-jukka.rissanen@linux.intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

I no longer work on this so better update the file.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6618e9b91b6c..2e03de59d700 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -171,7 +171,6 @@ F:	drivers/scsi/53c700*
 
 6LOWPAN GENERIC (BTLE/IEEE 802.15.4)
 M:	Alexander Aring <alex.aring@gmail.com>
-M:	Jukka Rissanen <jukka.rissanen@linux.intel.com>
 L:	linux-bluetooth@vger.kernel.org
 L:	linux-wpan@vger.kernel.org
 S:	Maintained
-- 
2.36.1

