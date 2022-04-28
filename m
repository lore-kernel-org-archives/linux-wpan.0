Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B85EC4332F
	for <linux-wpan@archiver.kernel.org>; Thu, 28 Apr 2022 03:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiD1DJW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiD1DJV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 27 Apr 2022 23:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEF2F2E9DE
        for <linux-wpan@vger.kernel.org>; Wed, 27 Apr 2022 20:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651115167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Yn6iA4hdzDYZvjsN/nl3B+u0y5prVHrZ7jxNMusXcWE=;
        b=NGtO0JGOf0rNoAhf36n+LxOezbozt/k3nNjX3K24dwaRxIvSafMus21e1od9WikllqwM7m
        8JCk4FCXX/Ea4wApEEVA8SIHh7ioIzpQyQLFNkqW0kzKYxuVq3VPQHTUw+r0heLcwibhlj
        QjF6L1ySgwNGWGJuuM2NDrYmyHs0U/Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-OwWjIDEmNG2DIh9EuAZ41g-1; Wed, 27 Apr 2022 23:06:01 -0400
X-MC-Unique: OwWjIDEmNG2DIh9EuAZ41g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C70B38039D7;
        Thu, 28 Apr 2022 03:05:58 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CA032166B4D;
        Thu, 28 Apr 2022 03:05:58 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     jukka.rissanen@linux.intel.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        stefan@datenfreihafen.org, torvalds@linuxfoundation.org
Subject: [PATCH bluetooth-next 0/3] net: 6lowpan: simplify lookup by nhc id
Date:   Wed, 27 Apr 2022 23:05:31 -0400
Message-Id: <20220428030534.3220410-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

this patch series removes the rb data structure for looking up a nhc by
nhc id. Instead we using the existing nexthdr lookup array by iterating
over it and find the right nhc by nhc id. It's simply not worth it to
use such complex handling for such small amount of nhc. As we only
support nhc ids which fits into 1 byte and there are not two byte nhc
ids values specified yet, we let the nhc layer only handle 1 byte values.
If there is the need for 2 byte nhc values we can add support for it.

- Alex

Alexander Aring (3):
  net: 6lowpan: remove const from scalars
  net: 6lowpan: use array for find nhc id
  net: 6lowpan: constify lowpan_nhc structures

 net/6lowpan/nhc.c               | 103 ++++++--------------------------
 net/6lowpan/nhc.h               |  38 +++++-------
 net/6lowpan/nhc_dest.c          |   9 +--
 net/6lowpan/nhc_fragment.c      |   9 +--
 net/6lowpan/nhc_ghc_ext_dest.c  |   9 +--
 net/6lowpan/nhc_ghc_ext_frag.c  |  11 +---
 net/6lowpan/nhc_ghc_ext_hop.c   |   9 +--
 net/6lowpan/nhc_ghc_ext_route.c |   9 +--
 net/6lowpan/nhc_ghc_icmpv6.c    |   9 +--
 net/6lowpan/nhc_ghc_udp.c       |   9 +--
 net/6lowpan/nhc_hop.c           |   9 +--
 net/6lowpan/nhc_ipv6.c          |  11 +---
 net/6lowpan/nhc_mobility.c      |   9 +--
 net/6lowpan/nhc_routing.c       |   9 +--
 net/6lowpan/nhc_udp.c           |   9 +--
 15 files changed, 48 insertions(+), 214 deletions(-)

-- 
2.31.1

