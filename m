Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE1C433F5
	for <linux-wpan@archiver.kernel.org>; Tue,  3 May 2022 07:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiECHfL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 3 May 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiECHfK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 May 2022 03:35:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD44F369FB;
        Tue,  3 May 2022 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651563098; x=1683099098;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s7qP+7A0NBt9Gg16q/B4wzGsyNnkkcxh4ZiCjQDjxeI=;
  b=GJFAZDe/iTtuTsqJUo+I2bv4oaXJFGPwmLMNxfukSLrDZq3HivZOeOat
   Oeq87Lms1kn5HW546/m3Kkfgts6vjS909YT5UA+JqquKWLF3tkLcODyfi
   h9oFxRtzqiWCm/mkor7t9mY3CyphXdR3r+Ui7kqsu3n6/iN/okm0nXoyA
   AgMaKWwvZb7yNbi//C7/xO0HmcsNcKSFQFxaZxu5+pYfENUvP9+fMp04w
   WPTRnTE0Xubwf1I+JQy66aqX9cPhH9YwGMStDazJOL1NpmH1YE4jFHNGN
   9akpqA1CrtCyOEZ6iKpWDZ83kSMUGYeB8m/NVaC1xiPt6utjBqBbvdGQe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267011398"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="267011398"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:31:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="584092985"
Received: from ghoyler-mobl.ger.corp.intel.com (HELO [10.252.33.128]) ([10.252.33.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 00:31:36 -0700
Message-ID: <1e81c3d8046c4dba4fdd0732ff63107d2558e6d2.camel@linux.intel.com>
Subject: Re: [PATCH bluetooth-next 1/3] net: 6lowpan: remove const from
 scalars
From:   Jukka Rissanen <jukka.rissanen@linux.intel.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        stefan@datenfreihafen.org, torvalds@linuxfoundation.org
Date:   Tue, 03 May 2022 10:31:22 +0300
In-Reply-To: <20220428030534.3220410-2-aahringo@redhat.com>
References: <20220428030534.3220410-1-aahringo@redhat.com>
         <20220428030534.3220410-2-aahringo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Wed, 2022-04-27 at 23:05 -0400, Alexander Aring wrote:
> The keyword const makes no sense for scalar types inside the
> lowpan_nhc
> structure. Most compilers will ignore it so we remove the keyword
> from
> the scalar types.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  net/6lowpan/nhc.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
> index 67951c40734b..2ac7da388c4d 100644
> --- a/net/6lowpan/nhc.h
> +++ b/net/6lowpan/nhc.h
> @@ -67,11 +67,11 @@ module_exit(__nhc##_exit);
>  struct lowpan_nhc {
>         struct rb_node  node;
>         const char      *name;
> -       const u8        nexthdr;
> -       const size_t    nexthdrlen;
> +       u8              nexthdr;
> +       size_t          nexthdrlen;
>         u8              *id;
>         u8              *idmask;
> -       const size_t    idlen;
> +       size_t          idlen;
>  
>         void            (*idsetup)(struct lowpan_nhc *nhc);
>         int             (*uncompress)(struct sk_buff *skb, size_t
> needed);


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka

