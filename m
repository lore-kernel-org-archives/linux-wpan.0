Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A055ECAAA1
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 08:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbiIFIVL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Sep 2022 04:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiIFIVK (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Sep 2022 04:21:10 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2586647FA
        for <linux-wpan@vger.kernel.org>; Tue,  6 Sep 2022 01:21:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9699EFF812;
        Tue,  6 Sep 2022 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662452466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oqy+SxhliPhZU/45DfCJwysO3QHLhao2R+k8GMnNT+k=;
        b=U/SKm7WQPR5TcUZh7NJsKH0XmvlUmnk6ReD4wWhM55Mn5BSt0VRISp57hqcZuXzM/kM3rz
        rbXDuNJdNUOZ7vbPyDl2c/DdUH2j9I0dG8yOgeJZzVxEe5qPrSunwGp+l3uuYwRyxpoKgj
        pOsNrASW1SATTEQqkk0QJ417l0EWCIE/1IsxcLvrJQffQfdYhHc6Dkvg+x5W3tfC7u0HHw
        zWcGunHHiQ3aYDnCgPQViNM9k9NL2sYzvVZJ23SnDgLpGPhQbHRXycJRGSuT5VTRLVuXTk
        Ai43SsCmedzynXpEXBJUywVhb+WJfvLiVNnMVHtzn4uFRfFiFfIyc07RWqspxg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     werner@almesberger.net
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH atusb/fw v2 1/3] Add .gitignore
Date:   Tue,  6 Sep 2022 10:21:02 +0200
Message-Id: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Prevent Git from tracking the bunch of generated files.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes in v2:
* New commit

 .gitignore | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 .gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..6bd4ce6
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,7 @@
+*.d
+*.bin
+*.elf
+*.dfu
+*.hex
+.version
+version.c
-- 
2.34.1

