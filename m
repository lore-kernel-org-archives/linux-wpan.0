Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A28C43334
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Jun 2022 04:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbiFMEiq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 13 Jun 2022 00:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiFMEhy (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jun 2022 00:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 691CB6413
        for <linux-wpan@vger.kernel.org>; Sun, 12 Jun 2022 21:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655095069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4V5EX5/9YZHbip5AGwxSlpLttI5vo9T1PLZKNwkf2f4=;
        b=S+mdIMtIwv5AT2589zu2ooAFhOan/dZT+mGBbUV/51JPd1/8WeynaaGYKebia+mYqUf25V
        eywCe/7VJ9OdFoaWptHvGH8xN444AYX4PgJw1coHCd+mPh1UiVFvn2GZO2RHt7fYL7xfIt
        INe8FJJfg7bq63OlFW00Kw3zOugPzpo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-9-SAt39FMvO80KnZPsInsQ-1; Mon, 13 Jun 2022 00:37:46 -0400
X-MC-Unique: 9-SAt39FMvO80KnZPsInsQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B7ED29AA383;
        Mon, 13 Jun 2022 04:37:46 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D798E492CA2;
        Mon, 13 Jun 2022 04:37:45 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        miquel.raynal@bootlin.com, aahringo@redhat.com
Subject: [PATCHv2 wpan-next 0/2] mac802154: atomic_dec_and_test() fixes
Date:   Mon, 13 Jun 2022 00:37:33 -0400
Message-Id: <20220613043735.1039895-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

I was wondering why nothing worked anymore. I found it...

changes since v2:

 - fix fixes tags in mac802154: util: fix release queue handling
 - add patch mac802154: fix atomic_dec_and_test checks got somehow
   confused 2 patch same issue

Alexander Aring (2):
  mac802154: util: fix release queue handling
  mac802154: fix atomic_dec_and_test checks

 net/mac802154/tx.c   | 4 ++--
 net/mac802154/util.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.31.1

