Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:36536 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbbEDGIj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 4 May 2015 02:08:39 -0400
Received: by wgen6 with SMTP id n6so139651858wge.3
        for <linux-wpan@vger.kernel.org>; Sun, 03 May 2015 23:08:38 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 4 May 2015 08:08:38 +0200
Message-ID: <CAG9Fz+sU3k2U03szspUF3oKnZOSrJrs=aG1Tgs=dnxxJ74=-3Q@mail.gmail.com>
Subject: Open task "missing enums", latest standard and where to put enums?
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi
I'm looking in to the first open task about missing enums.

### Is the latest standard from 2011?
Is the IEEE Std 802.15.4-2011 [1] the latest one to use?

How much attention should I pay to the more specific ones such as
802.15.4(g) for smart metering utility networks or (p) for Rail
communication and control? (I assume these are more about "policy" and
perhaps not so much about the "mechanism" to be implemented in the
linux kernel but I could be wrong here).

### Where to put enums? It all depends I assume...
"include/linux/[ieee802154.h|nl802154.h]" seems to include specific
IEEE802.15.4 defines/enums, anywhere else to look?

[1] http://standards.ieee.org/getieee802/download/802.15.4-2011.pdf

Regards
--
Christoffer Holmstedt
