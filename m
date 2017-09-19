Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw01.it.ntnu.no ([129.241.56.174]:44486 "EHLO
        mailgw01.it.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdISKKM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Sep 2017 06:10:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw01.it.ntnu.no (Postfix) with ESMTP id D8C59241492
        for <linux-wpan@vger.kernel.org>; Tue, 19 Sep 2017 12:03:36 +0200 (CEST)
Received: from mailgw01.it.ntnu.no ([127.0.0.1])
        by localhost (mailgw01.it.ntnu.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oM7QFHLzDwLA for <linux-wpan@vger.kernel.org>;
        Tue, 19 Sep 2017 12:03:36 +0200 (CEST)
Received: from [10.69.0.10] (unknown [163.172.170.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: davidfp)
        by mailgw01.it.ntnu.no (Postfix) with ESMTPSA id 23FC42413D9
        for <linux-wpan@vger.kernel.org>; Tue, 19 Sep 2017 12:03:36 +0200 (CEST)
From: David Palma <david.palma@ntnu.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Request for help/pointers -- 6LoWPAN over a VHF radio
Message-Id: <63F00C15-E887-4F18-A348-C17DCECEDB7E@ntnu.no>
Date: Tue, 19 Sep 2017 12:06:17 +0200
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

I have a couple questions about how to use 6LoWPAN over a VHF radio[1], which has a serial interface and supports a few radio operating modes[2] but not 802.15.4.

Is it possible to use the kernel's IEEE 802.15.4 implementation to do this?

If possible, where should I start? I believe this would a SoftMAC situation, but am not sure.

A few pointers or suggestions would be highly appreciated and I'm willing to learn more about kernel development and hopefully contributing.

Thanks in advance,
--
David

[1] http://skagmoelectronics.com
[2] http://www.skagmoelectronics.com/owl/downloads/manual_0_4_4.pdf