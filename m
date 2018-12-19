Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:59650 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbeLSO2U (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 19 Dec 2018 09:28:20 -0500
Received: from localhost.localdomain (p200300E9D74E972542AE244D155A9919.dip0.t-ipconnect.de [IPv6:2003:e9:d74e:9725:42ae:244d:155a:9919])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id CA4CDC6ECA
        for <linux-wpan@vger.kernel.org>; Wed, 19 Dec 2018 15:28:18 +0100 (CET)
From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: wpan-tools 0.9 release
Message-ID: <c88277c7-d2dc-3ef4-f92d-a8ea772a6b9d@datenfreihafen.org>
Date: Wed, 19 Dec 2018 15:28:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

It is a pleasure to announce the 0.9 release of wpan-tools.
Thanks to everyone who contributed!

The one big feature in this release is a configuration utility for
hwsim. A hardware simulation driver which landed mainline in the 4.19
kernel release.

Guido Günther contributed a patch from a packagers perspective. Thanks!

Alexander Aring (3):
wpan-ping: fix ifname setting
wpan-hwsim: hardware simulator configuration utility
wpan-hwsim: fix long option argument option for dot

Guido Günther (1):
Don't install examples

Stefan Schmidt (5):
hwsim: make sure lqi is always initialized
iwpan: fix clang compiler warning on absolute-value
examples: fix wrongly used unsigned attribute
build: hwsim: fix list of files needed for dist build
Release 0.9


https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.9/wpan-tools-0.9.tar.gz

sha256sum:
fa76d9c1874220e4b1f91c226f42baf1e372ea8ccf4b892effaf0d164448f608

https://github.com/linux-wpan/wpan-tools/releases/download/wpan-tools-0.9/wpan-tools-0.9.tar.xz

sha256sum:
a0bf858048f9a5888a0262a85ff4d0a1fff339fb4ede383aea36779fb6c9f90c

regards

Stefan Schmidt
