Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F8C433B4
	for <linux-wpan@archiver.kernel.org>; Fri, 23 Apr 2021 04:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6936100B
	for <linux-wpan@archiver.kernel.org>; Fri, 23 Apr 2021 04:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhDWESY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 23 Apr 2021 00:18:24 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17407 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhDWESY (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 23 Apr 2021 00:18:24 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 00:18:24 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1619150547; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=hpx6XwQ3ZyjJ2m7fp2F7pSJ10f5K69WIEJDdglHAPgil5Rg3sO7ty/drHdTGWZugqUjDTUb8j9+bPBLCMKlYtPc6QOj9PpSIZhlIjJ9QzQXABe9vcT9qs1pzJ5aWjqVYJS4DeTkt0+evNgwsyhiUbRDmp5nML74QRqJUOWWus54=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1619150547; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=ovELkitdepEboed/gVAZEcG2v0IlVO4bIoov9qocPHI=; 
        b=EP43QZUEdf8+gRWp0O1+mducaJrrk8xCz505yJr3/8irAq+OKDP0p2chhBL2z4G9PeguYCHJs4Hmr+ucOMBB9kHufGgx27XYHJS/meKAlj7+xDaDKhCCs316FINx1ELRMOEIeK53LeaamHHBu8YlhzIbTEIiPeHQh3KZAd4wDzw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-173-66-46-118.washdc.fios.verizon.net [173.66.46.118]) by mx.zohomail.com
        with SMTPS id 161915054532687.06870622077247; Thu, 22 Apr 2021 21:02:25 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     Dan Robertson <dan@dlrobertson.com>
Subject: [PATCH 0/2] net: ieee802154: fix logic errors
Date:   Fri, 23 Apr 2021 00:02:12 -0400
Message-Id: <20210423040214.15438-1-dan@dlrobertson.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

I hit two null derefs due to logic errors.

 - ieee802154_llsec_parse_key_id null deref if PAN ID is null.
 - ieee802154_llsec_parse_dev_addr null deref if the given mode
   does not match the given address.

New to ieee802154, so feedback would definitely be appreciated.

Dan Robertson (2):
  net: ieee802154: fix null deref in parse dev addr
  net: ieee802154: fix null deref in parse key id

 net/ieee802154/nl-mac.c   | 2 +-
 net/ieee802154/nl802154.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.31.1

