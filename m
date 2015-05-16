Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35906 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbEPPja (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 16 May 2015 11:39:30 -0400
Received: by wgbhc8 with SMTP id hc8so111404859wgb.3
        for <linux-wpan@vger.kernel.org>; Sat, 16 May 2015 08:39:29 -0700 (PDT)
Received: from omega (p20030064A929A303E2CB4EFFFE1BB546.dip0.t-ipconnect.de. [2003:64:a929:a303:e2cb:4eff:fe1b:b546])
        by mx.google.com with ESMTPSA id 16sm7794240wjs.41.2015.05.16.08.39.28
        for <linux-wpan@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 May 2015 08:39:28 -0700 (PDT)
Date: Sat, 16 May 2015 17:39:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: pending linux-wpan patches
Message-ID: <20150516153923.GB31491@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

at the moment there are many patches in my queue and these patches
touched mostly every file in the subsystem.

I prepare now patches for bluetooth-next. Two patches should go to
bluetooth, which are the fix for issue [0] and the rtnl_assertion
failure [1].

What's about the fakelb driver? Yea, this driver had few bugs but I
don't think that there are many users outside so we will simple send the
rework to bluetooth-next.

So I will prepare patch-series for Marcel in the next hours/days.

- Alex

[0] http://www.spinics.net/lists/linux-wpan/msg01929.html
[1] http://www.spinics.net/lists/linux-wpan/msg01894.html
