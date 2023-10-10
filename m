Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB964CD8CB4
	for <linux-wpan@archiver.kernel.org>; Tue, 10 Oct 2023 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjJJUL6 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 10 Oct 2023 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjJJUL5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 10 Oct 2023 16:11:57 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2999;
        Tue, 10 Oct 2023 13:11:54 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p4fc2fcbd.dip0.t-ipconnect.de [79.194.252.189])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 85BF7C0695;
        Tue, 10 Oct 2023 22:11:50 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        miquel.raynal@bootlin.com, netdev@vger.kernel.org
Subject: pull-request: ieee802154 for net 2023-10-10
Date:   Tue, 10 Oct 2023 22:09:43 +0200
Message-ID: <20231010200943.82225-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave, Jakub, Paolo.

An update from ieee802154 for your *net* tree:

Just one small fix this time around.

Dinghao Liu fixed a potential use-after-free in the ca8210 driver probe
function.

regards
Stefan Schmidt

The following changes since commit a2e52554c710b388df2d9d95b51cc1059af2aa22:

  Merge branch 'ravb-fix-use-after-free-issues' (2023-10-06 16:19:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git tags/ieee802154-for-net-2023-10-10

for you to fetch changes up to f990874b1c98fe8e57ee9385669f501822979258:

  ieee802154: ca8210: Fix a potential UAF in ca8210_probe (2023-10-07 20:37:38 +0200)

----------------------------------------------------------------
Dinghao Liu (1):
      ieee802154: ca8210: Fix a potential UAF in ca8210_probe

 drivers/net/ieee802154/ca8210.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)
