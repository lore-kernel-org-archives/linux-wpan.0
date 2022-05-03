Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5192DC433EF
	for <linux-wpan@archiver.kernel.org>; Tue,  3 May 2022 07:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiECHgE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 3 May 2022 03:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiECHgE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 May 2022 03:36:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548F369FB;
        Tue,  3 May 2022 00:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651563152; x=1683099152;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qy3FsmlPD/Mh6fJQiRMAQSJuVZfG66VesbUc4p6C3Qw=;
  b=N7SFhG9AdbB+yOKRHTC5/nDi7V8OTC4ODa25xXKBYuWrffvLf4uEbXVc
   B7sTfH2jLqlPwl+qr+nSxMAyeN5ihSvg7Hk/XcIB5O70RxgTG7xPM71u5
   uYYIxzzJi//ZrRTgggoWhyRGbX/X/3kgqXPEGYNex3DHAuDQ0recMxCK/
   IDIIe43uHqT8Nbar0kPFQ+4U4tIxesHu36neHldu6E3fUlYtPWFReyz7J
   59QfezVYzedZ3EOG4PXYo/oxyZT9bhea2z2MHdFJB6ULmE0Kb5t2fKkLB
   2BN6mHrvNVY3h9uxLyDfjLBwbegRArLYVTtdX0YnmDJ7/j4h1tj5bnQkS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247965852"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="247965852"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:32:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="653162441"
Received: from ghoyler-mobl.ger.corp.intel.com (HELO [10.252.33.128]) ([10.252.33.128])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:32:19 -0700
Message-ID: <b058f6ec77bef1570214be4711b16012ea030d2c.camel@linux.intel.com>
Subject: Re: [PATCH bluetooth-next 2/3] net: 6lowpan: use array for find nhc
 id
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        stefan@datenfreihafen.org, torvalds@linuxfoundation.org
Date:   Tue, 03 May 2022 10:32:16 +0300
In-Reply-To: <20220428030534.3220410-3-aahringo@redhat.com>
References: <20220428030534.3220410-1-aahringo@redhat.com>
         <20220428030534.3220410-3-aahringo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2022-04-27 at 23:05 -0400, Alexander Aring wrote:
> This patch will remove the complete overengineered and overthinking
> rb data
> structure for looking up the nhc by nhcid. Instead we using the
> existing
> nhc next header array and iterate over it. It works now for 1 byte
> values
> only. However there are only 1 byte nhc id values currently
> supported and IANA also does not specify large than 1 byte values
> yet.
> If there are 2 byte values for nhc ids specified we can revisit this
> data structure and add support for it.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  net/6lowpan/nhc.c               | 91 +++++--------------------------
> --
>  net/6lowpan/nhc.h               | 28 ++++------
>  net/6lowpan/nhc_dest.c          |  9 +---
>  net/6lowpan/nhc_fragment.c      |  9 +---
>  net/6lowpan/nhc_ghc_ext_dest.c  |  9 +---
>  net/6lowpan/nhc_ghc_ext_frag.c  | 11 +---
>  net/6lowpan/nhc_ghc_ext_hop.c   |  9 +---
>  net/6lowpan/nhc_ghc_ext_route.c |  9 +---
>  net/6lowpan/nhc_ghc_icmpv6.c    |  9 +---
>  net/6lowpan/nhc_ghc_udp.c       |  9 +---
>  net/6lowpan/nhc_hop.c           |  9 +---
>  net/6lowpan/nhc_ipv6.c          | 11 +---
>  net/6lowpan/nhc_mobility.c      |  9 +---
>  net/6lowpan/nhc_routing.c       |  9 +---
>  net/6lowpan/nhc_udp.c           |  9 +---
>  15 files changed, 37 insertions(+), 203 deletions(-)
> 
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> index d6bbbd4ab38b..019f121b2449 100644
> --- a/net/6lowpan/nhc.c
> +++ b/net/6lowpan/nhc.c
> @@ -12,77 +12,26 @@
>  

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

