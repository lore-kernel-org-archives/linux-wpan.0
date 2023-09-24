Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CEFCE7A88
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 12:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjIXMXD (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 08:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIXMXD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 08:23:03 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32836115
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 05:22:53 -0700 (PDT)
Received: from localhost.localdomain.datenfreihafen.local (p200300e9d71918519b00d9454c2dda6a.dip0.t-ipconnect.de [IPv6:2003:e9:d719:1851:9b00:d945:4c2d:da6a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@sostec.de)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 96510C02DE;
        Sun, 24 Sep 2023 14:22:45 +0200 (CEST)
From:   Stefan Schmidt <stefan@datenfreihafen.org>
To:     linux-wpan@vger.kernel.org
Cc:     alex.aring@gmail.com, miquel.raynal@bootlin.com,
        david.girault@qorvo.com, Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 0/9] wpan-tools: switch to SPDX header for license and copyright
Date:   Sun, 24 Sep 2023 14:22:22 +0200
Message-ID: <20230924122231.716878-1-stefan@datenfreihafen.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

I took some time to convert wpan-tools over to using the SPDX header format to
express copyright and license information. In this process we make the actual
license (ISC) more clear and allow downstream users of wpan-tools to have a
machine readable format for license compliance.

We are also using the reuse tool in our CI to check for this now and generate a
SBOM file as an example.

regards
Stefan Schmidt

Stefan Schmidt (9):
  m4: remove empty folder which only holds a .gitignore file
  license: clearly indicate license in file name and use new LICENSES
    folder
  wpan-ping: switch files to SPDX header for license and copyright
  wpan-hwsim: switch files to SPDX header for license and copyright
  src/nl802154.h: switch file to SPDX header for license and copyright
  examples: switch files to SPDX header for license and copyright
  src: switch files to SPDX header for license and copyright
  misc: switch remaining files to SPDX header for license and copyright
  workflow: add reuse job to check for REUSE compliance

 .github/workflows/main.yml   |  4 ++++
 .github/workflows/reuse.yml  | 19 +++++++++++++++++++
 .gitignore                   |  5 +++++
 COPYING                      | 25 +------------------------
 LICENSES/ISC.txt             | 23 +++++++++++++++++++++++
 Makefile.am                  |  4 ++++
 autogen.sh                   |  4 ++++
 configure.ac                 |  4 ++++
 examples/.gitignore          |  4 ++++
 examples/Makefile.am         |  4 ++++
 examples/README.examples     |  4 ++++
 examples/af_ieee802154_rx.c  | 23 ++++-------------------
 examples/af_ieee802154_tx.c  | 23 ++++-------------------
 examples/af_inet6_rx.c       | 23 ++++-------------------
 examples/af_inet6_tx.c       | 23 ++++-------------------
 examples/af_packet_rx.c      | 23 ++++-------------------
 examples/af_packet_tx.c      | 23 ++++-------------------
 m4/.gitignore                |  5 -----
 src/.gitignore               |  4 ++++
 src/Makefile.am              |  4 ++++
 src/event.c                  |  4 ++++
 src/info.c                   |  4 ++++
 src/interface.c              |  4 ++++
 src/iwpan.c                  |  3 +++
 src/iwpan.h                  |  4 ++++
 src/mac.c                    |  4 ++++
 src/nl802154.h               | 24 ++++++------------------
 src/nl_extras.h              |  4 ++++
 src/phy.c                    |  4 ++++
 src/scan.c                   |  4 ++++
 src/sections.c               |  4 ++++
 wpan-hwsim/Makefile.am       |  4 ++++
 wpan-hwsim/mac802154_hwsim.h |  4 ++++
 wpan-hwsim/wpan-hwsim.c      | 22 +++++-----------------
 wpan-ping/.gitignore         |  4 ++++
 wpan-ping/Makefile.am        |  4 ++++
 wpan-ping/README.wpan-ping   |  4 ++++
 wpan-ping/wpan-ping.c        | 22 +++++-----------------
 38 files changed, 183 insertions(+), 195 deletions(-)
 create mode 100644 .github/workflows/reuse.yml
 mode change 100644 => 120000 COPYING
 create mode 100644 LICENSES/ISC.txt
 delete mode 100644 m4/.gitignore

-- 
2.41.0

