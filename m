Return-Path: <SRS0=jj/+=A7=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B80DC433E1
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Jul 2020 09:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FEA2176B
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Jul 2020 09:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGTJk2 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:40:28 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:45772 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGTJk2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Jul 2020 05:40:28 -0400
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d7371614ec13d59c95910a08.dip0.t-ipconnect.de [IPv6:2003:e9:d737:1614:ec13:d59c:9591:a08])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 6061FC0476;
        Mon, 20 Jul 2020 11:40:26 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2020-07-20
Date:   Mon, 20 Jul 2020 11:40:09 +0200
Message-Id: <20200720094009.1807496-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org


Hello Dave.

An update from ieee802154 for your *net* tree.

A potential memory leak fix for adf7242 from Liu Jian,
and one more HTTPS link change from Alexander A. Klimov.

regards
Stefan Schmidt

The following changes since commit 473309fb8372365ad211f425bca760af800e10a7:

  net: dp83640: fix SIOCSHWTSTAMP to update the struct with actual configuration (2020-07-16 13:27:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git tags/ieee802154-for-davem-2020-07-20

for you to fetch changes up to 19dc36548be2027cb5a491511bc152493c1244bb:

  net: ieee802154: adf7242: Replace HTTP links with HTTPS ones (2020-07-20 08:51:38 +0200)

----------------------------------------------------------------
Alexander A. Klimov (1):
      net: ieee802154: adf7242: Replace HTTP links with HTTPS ones

Liu Jian (1):
      ieee802154: fix one possible memleak in adf7242_probe

 drivers/net/ieee802154/adf7242.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
