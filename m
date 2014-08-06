Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:59754 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbaHFPC1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Aug 2014 11:02:27 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so9019828wib.9
        for <linux-wpan@vger.kernel.org>; Wed, 06 Aug 2014 08:02:26 -0700 (PDT)
Received: from omega (p20030064A9783292E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a978:3292:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id fs17sm3075665wjc.6.2014.08.06.08.02.25
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Aug 2014 08:02:25 -0700 (PDT)
Date: Wed, 6 Aug 2014 17:02:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140806150216.GA30195@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: linux-wpan github repos updated
To: linux-wpan@vger.kernel.org

Hi,

I will send pull request to bluetooth-next branch the next days so I
updated the github repos to base on bluetooth-next instead net-next.

Please check if you pending patches will apply on this repository.

Patches for "net/6lowpan" should be go into bluetooth-next repository.

Why bluetooth-next?

The generic 6LoWPAN stuff is used by bluetooth and 802.15.4, that's why
it's better to base on bluetooth to have the 6lowpan generic code in
both branches most up-to-date.

I also accept all patches for linux-wpan-next only. We don't have a
right strategie at the moment and all people should always use
linux-wpan-next as kernel source. Simple: it makes no sense to send
patches into bluetooth if the complete stack is in an unusable state
and we don't have much users at current mainline kernel.

But this really depends on the fix, is it a compile error then this
should be fixed really fast and in the necessary branches.

- Alex
