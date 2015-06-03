Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34904 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760212AbbFCNIr (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 3 Jun 2015 09:08:47 -0400
Received: by labko7 with SMTP id ko7so7596954lab.2
        for <linux-wpan@vger.kernel.org>; Wed, 03 Jun 2015 06:08:44 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 3 Jun 2015 15:08:44 +0200
Message-ID: <CAPpUg6Oj5TbS9qwdor-uymsU5bzhUMxJXk=RBd+1UmPXwHVK=Q@mail.gmail.com>
Subject: error: nl802154 not found
From: Baptiste Clenet <bapclenet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>

Hi,

I finally managed to set up the at86rf212B with some edits in spi
driver and pinctrl driver.

Anyway, I've got an at86rf212B set up now and I wanted to use iwpan tools.
As soon as I use "iwpan list", I get an error: "nl802154 not found"


The at86rf230 driver seems to register an ieee802154 device without
errors: ieee802154_register_device(lp->dev);

What could be the problem?

Cheers,

Baptiste
