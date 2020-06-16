Return-Path: <SRS0=1fZ6=75=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66887C433DF
	for <linux-wpan@archiver.kernel.org>; Tue, 16 Jun 2020 06:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C38E2074D
	for <linux-wpan@archiver.kernel.org>; Tue, 16 Jun 2020 06:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgFPG6f (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:58:35 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:41922 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPG6e (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 16 Jun 2020 02:58:34 -0400
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71c61de2d263da9f29fb60d.dip0.t-ipconnect.de [IPv6:2003:e9:d71c:61de:2d26:3da9:f29f:b60d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 7A93AC0D4F;
        Tue, 16 Jun 2020 08:58:28 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 1/2] docs: net: ieee802154: change link to new project URL
Date:   Tue, 16 Jun 2020 08:58:13 +0200
Message-Id: <20200616065814.816248-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

We finally came around to setup a new project website.
Update the reference here.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 Documentation/networking/ieee802154.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/ieee802154.rst b/Documentation/networking/ieee802154.rst
index 36ca823a1122..6f4bf8447a21 100644
--- a/Documentation/networking/ieee802154.rst
+++ b/Documentation/networking/ieee802154.rst
@@ -30,8 +30,8 @@ Socket API
 
 The address family, socket addresses etc. are defined in the
 include/net/af_ieee802154.h header or in the special header
-in the userspace package (see either http://wpan.cakelab.org/ or the
-git tree at https://github.com/linux-wpan/wpan-tools).
+in the userspace package (see either https://linux-wpan.org/wpan-tools.html
+or the git tree at https://github.com/linux-wpan/wpan-tools).
 
 6LoWPAN Linux implementation
 ============================
-- 
2.25.4

