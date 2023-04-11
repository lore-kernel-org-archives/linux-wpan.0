Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8FC76196
	for <linux-wpan@archiver.kernel.org>; Tue, 11 Apr 2023 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDKN0W (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 11 Apr 2023 09:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKN0V (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2023 09:26:21 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A1149D8
        for <linux-wpan@vger.kernel.org>; Tue, 11 Apr 2023 06:26:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98CE210000E;
        Tue, 11 Apr 2023 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681219579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eJk+Guz5MtFANJTJ4CepnErvdQBYBJisuG+5NtZ5rzs=;
        b=Ha5n2G8Lw9/bv6c5phc9/GvABCYIwdo64tWR+WPXpGMxtrgqDhlz5LHT/gcbQ1KWhESUd9
        M/E90HldWSMG0sxyMU0FyCfmNZ6hQ41oX1EPG1A3jdJU/05u5ZRGXVDChnRnA6zhM34N6K
        zA4kts9Ak5lzoO8ynM3Fn0+H7U9nAI+inXzUZm/FVmlaOK2gJ8+SEZLkwkdS8rNvJwElub
        3WcbpeqenO7LcQ4rVGkko/g8bmuHxzBXjUFTR0mMxMTkdb9DQMIeMQet0dmwSEhsZZm5zN
        GtnibdVPURMVxiw4I/5bGKOkFJGnK2HOrST2zBsaTkEd8iTNChZSqW/7UNTtxg==
Date:   Tue, 11 Apr 2023 15:26:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Wpan Mailing List <linux-wpan@vger.kernel.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Repository changes for linux-wpan
Message-ID: <20230411152616.17f70d99@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Stephen,

I don't know if you were already tracking Stefan's wpan and wpan-next
tree but as we are starting a maintainers group to relieve Stefan and
lighten the reviewing load on Alexander, we switched to new trees:

-T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git
-T:     git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-nex=
t.git
+T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan.git
+T:     git git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git

We will now maintain:

* wpan.git master
  This is our "to net" tree, with fixes, mainly.
* wpan-next.git master
  This is our "to net-next" tree, with features, mainly.
  We plan on not rebasing this branch.
* wpan-next.git staging
  This is the same as the wpan-next.git master branch, but we allow
  ourselves to force push this one in case of problem. Once our tests
  have passed and if no warning was triggered in the linux-next tree
  you maintain, we will merge the branch in the master branch mentioned
  above.

We would like to kindly ask you to update your scripts to take these
branches into your linux-next tree.

Thanks a lot!
Miqu=C3=A8l, on behalf of the wpan team
