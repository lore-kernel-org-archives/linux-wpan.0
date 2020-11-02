Return-Path: <SRS0=PnyL=EI=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D29C00A89
	for <linux-wpan@archiver.kernel.org>; Mon,  2 Nov 2020 11:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06FD21556
	for <linux-wpan@archiver.kernel.org>; Mon,  2 Nov 2020 11:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxwSTCHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgKBLqL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgKBLp5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Nov 2020 06:45:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271BC061A55
        for <linux-wpan@vger.kernel.org>; Mon,  2 Nov 2020 03:45:48 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so14211519wrs.5
        for <linux-wpan@vger.kernel.org>; Mon, 02 Nov 2020 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wO3DZUe4v/2VFg7iK8pRPHz2KfePFYcH1bmhyPk8rVQ=;
        b=mxwSTCHJXfkm9QxIRzdWvvf6dxhtPXbmtDgBcU+bx+1CFUbQ75z70+OO18gi9tXNG5
         eaJtTaZq5qTYfhtyuJc0RLNtgtupNknmAfdDjt+atyOBtvn59pEWTsFT6vubLHaj1dYh
         C+ASzGBSNwAvk0fh0SSB6/okY7o5tWIPnfh9dVWJv3Q5zNJFenOFsn/orWIZ9O7veTd6
         KQ4B8mDGYo4F4bLl16h6/rU0s8oMYRhN8sBGmE7LQzrEoSEUCp/24h+nPu1Y47uBvLq8
         puQWJR0uoMjhogCNgA14CKVYiQONorlvpTu5VneJM1R1oLDnwtGbmNIDt1Xi33+vMsdR
         r8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wO3DZUe4v/2VFg7iK8pRPHz2KfePFYcH1bmhyPk8rVQ=;
        b=S8kfDfLYGGp6FP5ZdRMT/YWpoOyLgVShhbpPD51cfO/Mwk9JGk39qnuAMF+I6Vxfcw
         K2DhwHHEjUc+CmKzU0k9piJBW9nUwJo3fPfdM3FDBcVa9vZ079XhjbL1xKavO964S1Vc
         79b8JIZdcP/WtTSWIjHUNnuZzfGxQ/n4gIPkYTWisdakgFlSrdI3ZNbuijqBLMucA4Cq
         4XTuVB2HQvsQhQokK26IfFi7+Q8wytbILFNlcsdafn55ZtGb+1jGdmlEit+/kJ2VZ9b6
         TNkZHG/a4I7pkkSiC/XxSh9eNzgjoTIFrM/QET6yXrXPQDCOreK3PVBDt+4oLoZyi0eT
         fioA==
X-Gm-Message-State: AOAM532zVuKSxgcsvU7mgyALe8hy4uR2NZrdhAvgsyiFbbOTfVv2qY6N
        TzF1NzJYke5eHjdYUpHO1K4yg5ws8b0JQQ==
X-Google-Smtp-Source: ABdhPJzkteUP54xGsBZR9fcdINOLUtFH7SmKsmGUmAokF70EMPtdeIkFyyWIkzCECam1TRe43qUO3A==
X-Received: by 2002:adf:fe48:: with SMTP id m8mr19497585wrs.127.1604317547698;
        Mon, 02 Nov 2020 03:45:47 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id g66sm15545352wmg.37.2020.11.02.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:45:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net
Cc:     Lee Jones <lee.jones@linaro.org>,
        Harry Morris <h.morris@cascoda.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 23/30] net: ieee802154: ca8210: Fix incorrectly named function param doc
Date:   Mon,  2 Nov 2020 11:45:05 +0000
Message-Id: <20201102114512.1062724-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102114512.1062724-1-lee.jones@linaro.org>
References: <20201102114512.1062724-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/ieee802154/ca8210.c:724: warning: Function parameter or member 'cas_ctl' not described in 'ca8210_rx_done'
 drivers/net/ieee802154/ca8210.c:724: warning: Excess function parameter 'cas_ctrl' description in 'ca8210_rx_done'

Cc: Harry Morris <h.morris@cascoda.com>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ieee802154/ca8210.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 9b3ab7acad37e..3a2824f24caa8 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -715,7 +715,7 @@ static void ca8210_mlme_reset_worker(struct work_struct *work)
 /**
  * ca8210_rx_done() - Calls various message dispatches responding to a received
  *                    command
- * @cas_ctrl: Pointer to the cas_control object for the relevant spi transfer
+ * @cas_ctl: Pointer to the cas_control object for the relevant spi transfer
  *
  * Presents a received SAP command from the ca8210 to the Cascoda EVBME, test
  * interface and network driver.
-- 
2.25.1

