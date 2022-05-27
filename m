Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB244C433EF
	for <linux-wpan@archiver.kernel.org>; Fri, 27 May 2022 07:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348329AbiE0H4v (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 27 May 2022 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345044AbiE0H4r (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 May 2022 03:56:47 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F56FFD349;
        Fri, 27 May 2022 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653638198; x=1685174198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOdOMyeM/Ewif0zQ3Hqg7oUO5xeNmrmmhTh727FQsQQ=;
  b=PdR4UX5HyFgqSNX8KsKsGLZxd2WB4Yr0NJwCYiacQGpQ2FagKjcaKIB1
   yl+yzFyV8cNJTaJLj9SUX5jdL3Lxv9HqtsuLahP5g7RCpVdiGyp9NcZan
   TVgGi8nXfKb6AlMKxLy85u4PmR38OYpQUSyaRpnjoi840FEAjbm9zAv/h
   txqjhf32IjruVIXen3uFhmHm8Lb9rHTo4gVwjUTYq6Qla220i4ShgobQL
   HxkdC4ZwXY9BzCPCwNXCGkJboI0EMJa5o5ZWiZz71GEahiXeQNnmZsHFI
   jYKjPwfK6T8DNVX8PG8Qqtx1WfUFdRxf6oul6yYYCtBNbGP70x09wxZOJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="360800044"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="360800044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 00:56:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="603742445"
Received: from llistew-mobl1.ger.corp.intel.com (HELO jrissane-mobl2.fritz.box) ([10.252.40.127])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 00:56:34 -0700
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     alex.aring@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        pmenzel@molgen.mpg.de,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Remove Jukka Rissanen as 6lowpan maintainer
Date:   Fri, 27 May 2022 10:56:25 +0300
Message-Id: <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526162806.16618-1-jukka.rissanen@linux.intel.com>
References: <20220526162806.16618-1-jukka.rissanen@linux.intel.com>
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

