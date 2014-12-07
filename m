Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:53834 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbaLGPIY (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 7 Dec 2014 10:08:24 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so4394246wgh.41
        for <linux-wpan@vger.kernel.org>; Sun, 07 Dec 2014 07:08:22 -0800 (PST)
Received: from omega (p20030064A92813F3E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a928:13f3:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id n3sm6086223wiw.5.2014.12.07.07.08.21
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Dec 2014 07:08:22 -0800 (PST)
Date: Sun, 7 Dec 2014 16:08:17 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: [ANNOUNCE] wpan-tools 0.3 released
Message-ID: <20141207150814.GA9532@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I'm happy to announce that I've just released wpan-tools 0.3.
This is our first "real" release, the new kernel 3.18 will contain the
nl802154 interface. The old netlink interface will be removed soon and is
deprecated now. At the moment you can still use both userspace tools, but
I don't recommend the lowpan-tools.

New release will be found now under:

http://wpan.cakelab.org/releases/

Github has no option to make releases with "make distcheck" that's why I
will upload it to this location.

Below you can see the shortlog from 0.2 to 0.3 version. Only some fixes
to make a release with "make distcheck" possible.

Thanks to all contributors.

- Alex

Alexander Aring (4):
  iwpan: use autoconf version defines
  configure: fix CLFAGS definition
  configure: change archive generation
  configure: version bump

Stefan Schmidt (3):
  configure: Fail if libnl3 dependency is not found
  build: add header files to SOURCES
  configure: do not use check-news for now
