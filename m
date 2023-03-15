Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5D0C74A5B
	for <linux-wpan@archiver.kernel.org>; Wed, 15 Mar 2023 18:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjCOSUS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjCOSTx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 15 Mar 2023 14:19:53 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF257EA18
        for <linux-wpan@vger.kernel.org>; Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r16so17191718qtx.9
        for <linux-wpan@vger.kernel.org>; Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678904377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CvInQkgrtFswN6a5J7y2T4rUDkhwlp0YkwDUjcLdMc=;
        b=KnGZSFdqJfe5cBkq4aueaxEmiLAtr5exCnajnLei2Srqi9rxmdUuZI63NoOHKdJ2+o
         zHIUImu4xXpy20R3uMo162yktC1I33Kf0ShmUAEpgNBOOhn4IjHGJR07QliUY+ctVwZQ
         HWm3wiihMoB3X4nUyfx7NPhrp6HpBq8pnQ1lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678904377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CvInQkgrtFswN6a5J7y2T4rUDkhwlp0YkwDUjcLdMc=;
        b=j7dPYcY9dOB28fnkLs/o5hBB7+UTvr4gddwUPeuXv+d28RR34LnwA+lHU0qpnsEOIY
         z8U6q3jE9bMuGdjR1rSyCaMFd6zMLoXo62dO4phnujSDV52oTiZpi1FcsVwjRW/KyGb1
         j87b/X5hXEwCp9JzrNeNACXMxh4n5xF0ORhqexm7gxXLK+jFoDhlNtvwNZXhJ42Kd68f
         XYvzR+X7QDjxjGHm2Qg3t0damSfd+FzxTlOsoEVcgo02Cuh3Bju4tFknRFSyO96Zxgks
         TAQvPFH+yHhid7Af4CsHURcui5z5AJglsEiaL/dlRNTCOFKkAVXtA2MhS9GjPkW285EJ
         MMUw==
X-Gm-Message-State: AO0yUKUPf0Kx4pXpCVOFc+r3gZAF/SgYCH6d/HDQKIa4uAmpf4B310nc
        uelFRRPyen+EtI8H/E88aun83A==
X-Google-Smtp-Source: AK7set9oYtHUFfrwlWQH2asNzIQYPCQs5mupkZKf2svsaI8b0gVoCB+qZF/+IC8hu7UCi4R1iYnkCg==
X-Received: by 2002:a05:622a:50c:b0:3d3:33bd:a29 with SMTP id l12-20020a05622a050c00b003d333bd0a29mr1523968qtx.16.1678904377358;
        Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v125-20020a379383000000b007458ae32290sm4113974qkd.128.2023.03.15.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:19:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Girault <david.girault@qorvo.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexander Aring <aahringo@redhat.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] mac802154: Rename kfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed, 15 Mar 2023 18:18:59 +0000
Message-Id: <20230315181902.4177819-12-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315181902.4177819-1-joel@joelfernandes.org>
References: <20230315181902.4177819-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The k[v]free_rcu() macro's single-argument form is deprecated.
Therefore switch to the new k[v]free_rcu_mightsleep() variant. The goal
is to avoid accidental use of the single-argument forms, which can
introduce functionality bugs in atomic contexts and latency bugs in
non-atomic contexts.

The callers are holding a mutex so the context allows blocking. Hence
using the API with a single argument will be fine, but use its new name.

There is no functionality change with this patch.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/mac802154/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 9b0933a185eb..5c191bedd72c 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -52,7 +52,7 @@ static int mac802154_scan_cleanup_locked(struct ieee802154_local *local,
 	request = rcu_replace_pointer(local->scan_req, NULL, 1);
 	if (!request)
 		return 0;
-	kfree_rcu(request);
+	kvfree_rcu_mightsleep(request);
 
 	/* Advertize first, while we know the devices cannot be removed */
 	if (aborted)
@@ -403,7 +403,7 @@ int mac802154_stop_beacons_locked(struct ieee802154_local *local,
 	request = rcu_replace_pointer(local->beacon_req, NULL, 1);
 	if (!request)
 		return 0;
-	kfree_rcu(request);
+	kvfree_rcu_mightsleep(request);
 
 	nl802154_beaconing_done(wpan_dev);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

