Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A643C48BDF
	for <linux-wpan@archiver.kernel.org>; Fri, 11 Jun 2021 01:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D49D61376
	for <linux-wpan@archiver.kernel.org>; Fri, 11 Jun 2021 01:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFKCBb (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:01:31 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:55147 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhFKCBb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 10 Jun 2021 22:01:31 -0400
Received: by mail-pj1-f42.google.com with SMTP id g24so4774026pji.4;
        Thu, 10 Jun 2021 18:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uam97m8fS2yjD+Mrnj2iP7fVHgATXtrgF4fGudBtGmk=;
        b=Dyt4nk1Pu8xd5m9v8yRBgfT+MsrytptON9aiTwNohR8w7yKPqvQYhj0At1IFfSOmnM
         Nt6FTlxnME06uzWTVhEr0JPs54oTDdqMF/Br14RD6Acmv9pFgJeVLD8UxaPV/YUkJxjm
         brLGF7lk+Hfe+qrIuEJZdr8nbzkc7EZNvC5iAk5qWPFmV/Y9PCb7wgTSloOLYcgokTEj
         4eQZtq1+sRaaHlvIS6OYWiikqtd2zbu9RMpu3Eg0DAoa5J32w3fSWWV8XAJaJapUBB/M
         VdzBsrRrkapgP135Zuy+4jtZmp9DwHcDY/nnePw9bFkHtFFBFIikz7Pd+50HbU1nIUVY
         K86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uam97m8fS2yjD+Mrnj2iP7fVHgATXtrgF4fGudBtGmk=;
        b=gf7ztcgUWcD55ZlfzKAIGd9t/GDxIODRr1vwn5r4ur7lteIrPWCGEnU7diljsVrAu6
         07Ki0EpWVshsj3nlbVIWBWz3tqapN83vgjO1sRyWLsKAvvvWkPaWWkc4Z/ooGaKXexxF
         khAQXbvUQAfFO1xXN5/tvYyXwWwrT4rNVjKjPgoGE0Gd5cxPLXG7h7LPcJROT7VC9Obq
         UTMCgVjY4Tc9uD4tppFDY6n/mwt/czfpXeht+3s7lMHEYSqXOA8AbXZ8R6A0cYmTWFyg
         JdgPxxvAB/8F1OekvpKWPMhRgk05qG2bwJ3ECYcDK+kNTnNS03cugpE4b+YD4gHOKTnt
         p34A==
X-Gm-Message-State: AOAM532lGydPqCh0JZUFJMAAAgJfuI2nAbS6/SLyS8drmF42FpDgFWH7
        ssJeLVGRvKHvyfjFx71u/Ww=
X-Google-Smtp-Source: ABdhPJx2Bs2oQ2y94cYwdskRqSzpReoujld6udSr5ON+lL6C+/tbdqes5CqOm3yNqMdFAXKWq2QSlw==
X-Received: by 2002:a17:90a:6b46:: with SMTP id x6mr6366579pjl.163.1623376705046;
        Thu, 10 Jun 2021 18:58:25 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.34])
        by smtp.gmail.com with ESMTPSA id md24sm8856222pjb.43.2021.06.10.18.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 18:58:24 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     alex.aring@gmail.com, stefan@datenfreihafen.org,
        davem@davemloft.net, kuba@kernel.org
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dongliang Mu <mudongliangabcd@gmail.com>
Subject: [PATCH] ieee802154: hwsim: Fix possible memory leak in hwsim_subscribe_all_others
Date:   Fri, 11 Jun 2021 09:58:12 +0800
Message-Id: <20210611015812.1626999-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

In hwsim_subscribe_all_others, the error handling code performs
incorrectly if the second hwsim_alloc_edge fails. When this issue occurs,
it goes to sub_fail, without cleaning the edges allocated before.

Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/net/ieee802154/mac802154_hwsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index da9135231c07..366eaae3550a 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -715,6 +715,8 @@ static int hwsim_subscribe_all_others(struct hwsim_phy *phy)
 
 	return 0;
 
+sub_fail:
+	hwsim_edge_unsubscribe_me(phy);
 me_fail:
 	rcu_read_lock();
 	list_for_each_entry_rcu(e, &phy->edges, list) {
@@ -722,8 +724,6 @@ static int hwsim_subscribe_all_others(struct hwsim_phy *phy)
 		hwsim_free_edge(e);
 	}
 	rcu_read_unlock();
-sub_fail:
-	hwsim_edge_unsubscribe_me(phy);
 	return -ENOMEM;
 }
 
-- 
2.25.1

