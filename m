Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:61741 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaHSJgJ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 05:36:09 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so6172209wes.11
        for <linux-wpan@vger.kernel.org>; Tue, 19 Aug 2014 02:36:08 -0700 (PDT)
Received: from omega (p20030064A97F040EE2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a97f:40e:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id ph10sm49026940wjb.25.2014.08.19.02.36.07
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Aug 2014 02:36:07 -0700 (PDT)
Date: Tue, 19 Aug 2014 11:35:58 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: New organization between wpan and bluetooth
Message-ID: <20140819093556.GA827@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

We need a new behaviour to apply patches to linux-wpan and linux-wpan-next.

I need to do a last force update to the master branches, these are really the
lastest! Sorry for that.

The new behaviour is to apply all patches to a testing branch in
linux-wpan and linux-wpan-next.

All patches go into linux-wpan/testing and linux-wpan-next/testing. Then
I send all patches to bluetooth/bluetooth-next master branches. After
Marcel apply these patches to bluetooth and bluetooth-next I will rebase
the master branch according to the bluetooth/bluetooth-next master branch.

I can't apply new patches on the linux-wpan master branches when I don't
use pull-request to send patches to Marcel. Some day I will do that but
for now I use git send-email.


To clarify, bug fixes should be send to linux-wpan and all other patches
should go into linux-wpan-next. At first this should show into the
testing branch of these repositories.

- Alex
