Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF152C433F5
	for <linux-wpan@archiver.kernel.org>; Tue,  3 May 2022 07:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiECHg3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 3 May 2022 03:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiECHg2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 May 2022 03:36:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5692369FB;
        Tue,  3 May 2022 00:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651563177; x=1683099177;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MVFUqCIbnZap9ZQFYMXuDljnjqzyCdpjKwkY3YBXGo=;
  b=IpAQVxqG/P8Y92nFFcwlikfJbLNsXK9vQ93mhYiW5vkqtPkedzNmhdpF
   qJz1kcQ//mTP61G/Ota4QhHQm+btH5xAlfOwT6IdgGQJJyGu/c0lphsMD
   nnH77kouYSFvRwcM9IH5sW4ShlfjMi6tt0g9X5ZCXBRQ024+T7awf5e7V
   4dxntguBa1dXOwwZTwsCX2XMA2YOx1eLTUqbiXtFPE7a5c1/oN89w83xm
   E6a4LnDJgU2KD3tt/MYsS/at9dHldhpzRf44Qm1ZyFm4vQHSHNy6pIQQs
   ZnjGZ/oZnVy5cESRdcE1TB/PPS2CYnYOrGEgHRyjaNdHt6AQDsgX5ylkg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267011776"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267011776"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:32:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="598971003"
Received: from ghoyler-mobl.ger.corp.intel.com (HELO [10.252.33.128]) ([10.252.33.128])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:32:55 -0700
Message-ID: <e2b444297b5a815e4659c963c98e884d012a9cbd.camel@linux.intel.com>
Subject: Re: [PATCH bluetooth-next 3/3] net: 6lowpan: constify lowpan_nhc
 structures
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        stefan@datenfreihafen.org, torvalds@linuxfoundation.org
Date:   Tue, 03 May 2022 10:32:52 +0300
In-Reply-To: <20220428030534.3220410-4-aahringo@redhat.com>
References: <20220428030534.3220410-1-aahringo@redhat.com>
         <20220428030534.3220410-4-aahringo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2022-04-27 at 23:05 -0400, Alexander Aring wrote:
> This patch constify the lowpan_nhc declarations. Since we drop the rb
> node datastructure there is no need for runtime manipulation of this
> structure.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  net/6lowpan/nhc.c | 16 ++++++++--------
>  net/6lowpan/nhc.h |  6 +++---
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> index 019f121b2449..7b374595328d 100644
> --- a/net/6lowpan/nhc.c
> +++ b/net/6lowpan/nhc.c
> @@ -12,12 +12,12 @@
> 


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

