Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D3EB64D9
	for <linux-wpan@archiver.kernel.org>; Mon, 19 Jun 2023 07:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjFSHJg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 19 Jun 2023 03:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFSHJf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 19 Jun 2023 03:09:35 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EC106
        for <linux-wpan@vger.kernel.org>; Mon, 19 Jun 2023 00:09:34 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d715954d26b5d993c1929d94.dip0.t-ipconnect.de [IPv6:2003:e9:d715:954d:26b5:d993:c192:9d94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 80CE2C0244;
        Mon, 19 Jun 2023 09:09:31 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        miquel.raynal@bootlin.com, netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2023-06-19
Date:   Mon, 19 Jun 2023 09:09:27 +0200
Message-Id: <20230619070927.825332-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net* tree:

Two small fixes and MAINTAINERS update this time.

Azeem Shaikh ensured consistent use of strscpy through the tree and fixed
the usage in our trace.h.

Chen Aotian fixed a potential memory leak in the hwsim simulator for
ieee802154.

Miquel Raynal updated the MAINATINERS file with the new team git tree
locations and patchwork URLs.

regards
Stefan Schmidt

The following changes since commit 209373537648d815a104c3af787663d7db06bd5d:

  Merge branch 'bnxt_en-3-bug-fixes' (2023-03-29 21:48:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2023-06-19

for you to fetch changes up to cd9125030689dda69f73f6c2843d63135cb383f0:

  ieee802154: Replace strlcpy with strscpy (2023-06-16 22:14:24 +0200)

----------------------------------------------------------------
Azeem Shaikh (1):
      ieee802154: Replace strlcpy with strscpy

Chen Aotian (1):
      ieee802154: hwsim: Fix possible memory leaks

Miquel Raynal (2):
      MAINTAINERS: Update wpan tree
      MAINTAINERS: Add wpan patchwork

 MAINTAINERS                              | 5 +++--
 drivers/net/ieee802154/mac802154_hwsim.c | 6 ++++--
 net/ieee802154/trace.h                   | 2 +-
 net/mac802154/trace.h                    | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)
