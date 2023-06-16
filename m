Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05CFEB64D7
	for <linux-wpan@archiver.kernel.org>; Fri, 16 Jun 2023 12:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjFPMSS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 16 Jun 2023 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbjFPMSO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 16 Jun 2023 08:18:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E887B30E0
        for <linux-wpan@vger.kernel.org>; Fri, 16 Jun 2023 05:18:13 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A20183F36A
        for <linux-wpan@vger.kernel.org>; Fri, 16 Jun 2023 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917892;
        bh=soiKTuNI2szr+B3DMv/HAX9nLtIBEiY4szgRtPOrfZw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JBTYlmbbr/DNvaBZj25SKqk2zVwGiJNUjsEeMKkN3yHSzHNco0wtov6+dZca6pOJy
         YsNw4U1YXxXTzENfRbppgQS7xVHBqeRl3pqyXL30gXjzcR1E+OQaAnzJHtuGF6oEBD
         Wjgrme/P8Heo8+4bhx7aecO2MyFDjge183++k2oTsgPOPadKL8rlBCCTMJaETu0Mtd
         +FqTLxuxX9ZiWf5q1//iEnnQf+tYvhmcqRUJhe6N4tArq+kok6URw1NO5/td0/5TuY
         mqfaCY4F3eJem+7Pl1eCRaxctwE2mtNWqaWdhXMhZY29RJp2uOSu/URx7Br5giVFLN
         dbaaqdU9eyNDQ==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f84a8b00e3so558300e87.0
        for <linux-wpan@vger.kernel.org>; Fri, 16 Jun 2023 05:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917890; x=1689509890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soiKTuNI2szr+B3DMv/HAX9nLtIBEiY4szgRtPOrfZw=;
        b=fQUBhJdG9PryQCPem2brPLXUAusLht6SFCFqKlf//va5Fj3TY0NvIuKATSSfCJP8Py
         uzyJiuIv7eBOojF3BGKm8sP/xapVKg868LNDcufEK20ExZAOksq9Wf0YH8FdLDtGJiEe
         X9rJQ69XhVdkcOiHdY3GpA6YLicqnZkoqJDvT1QEn0lpaq8cHNucQRUo1gXcpWvxmc5s
         JtrIGaPmZHA6aWiZkewdsh06ARdJ7zrPgVBOUbQDG5JY+lNuL21GEo2UhFlGhb34DXQw
         ZjNGhiKb1sZdgdPti0F7hqfYwz/jkSD+0uS76wol7pFTQMRw4RK8593pmR55hUZmttBr
         ZsMA==
X-Gm-Message-State: AC+VfDyYcZwwLBciGbcLtxtF/LSf3cg8YM2+3N9m5bUzO/Uiu4F9Vi/R
        xbdWwMCc/2IycFZ7h6Cgp0fmRH6tioIH4Ztv8mxoIAIAPo3HmxD3oRqIZ4h9h9f9tzy48bHzQjR
        M98YCXzNIC+cvS2/NsJT1UTaUugWJ1KsN5l2Y4v8=
X-Received: by 2002:a19:e308:0:b0:4f8:4673:26ca with SMTP id a8-20020a19e308000000b004f8467326camr1292294lfh.47.1686917890089;
        Fri, 16 Jun 2023 05:18:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/crAkK52hQhs4lvyn5+P+QYCK7oaPxGTbDvwaNgwbMhqTFQaK3EOu886oH2s+W1wZI3bZJg==
X-Received: by 2002:a19:e308:0:b0:4f8:4673:26ca with SMTP id a8-20020a19e308000000b004f8467326camr1292275lfh.47.1686917889721;
        Fri, 16 Jun 2023 05:18:09 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b003f7ff6b1201sm2045217wmf.29.2023.06.16.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:18:09 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     michael.hennerich@analog.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:18:07 +0200
Message-Id: <20230616121807.1034050-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/net/ieee802154/adf7242.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index f9972b8140f9..a03490ba2e5b 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1348,3 +1348,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.37.2

