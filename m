Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33387 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbbIIM03 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Sep 2015 08:26:29 -0400
Received: by lbcjc2 with SMTP id jc2so4677982lbc.0
        for <linux-wpan@vger.kernel.org>; Wed, 09 Sep 2015 05:26:27 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 9 Sep 2015 14:26:27 +0200
Message-ID: <CAPpUg6MbD04CcGAkOfs=NB4hS_3nqt-v38edwsXCd1sF-_3R1w@mail.gmail.com>
Subject: At86rf230 sleep state
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I looked at the at86rf230 driver on bluetooth-next branch and I saw the
two functions concerning the sleep state:

at86rf230_sleep(struct at86rf230_local *lp)

at86rf230_awake(struct at86rf230_local *lp)


I'm wondering if the transceiver can wake up from a received frame if
it is in SLEEP State? As far as I can see on the datasheet, it is not
able to. Am I wrong?

Alex Aring?

Cheers,

-- 
Baptiste
